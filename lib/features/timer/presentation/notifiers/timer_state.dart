import 'dart:convert';
import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/auth/data/model/user.dart';
import 'package:flutter_achiver/features/auth/data/service/firestore_user_service.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';
import 'package:flutter_achiver/features/timer/presentation/model/timer_durations_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

alarmCallback() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await notifications.initialize(
      InitializationSettings(AndroidInitializationSettings('app_icon'), null));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.popupbits.achiver',
      'Achiver',
      'Achiver - Pomodoro timer plus time tracker',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'achiver');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  notifications.show(
    0,
    prefs.getString("notification_title"),
    prefs.getString("notification_details"),
    platformChannelSpecifics,
    payload: 'timer payload',
  );
  player.play("break-alarm.mp3");
}

AudioCache player = AudioCache(prefix: "audios/");

class TimerState extends ChangeNotifier {
  User user;
  Project _project;
  PomoTimer _currentTimer;
  bool _timerRunning;
  DateTime _today;
  DateTime timerStartedAt;
  int _workSessionsCompletedToday;
  final int alarmId = 1;
  SharedPreferences prefs;
  final String timerKey = "running_timer";
  Duration elapsed;

  Project get project => _project;
  PomoTimer get currentTimer => _currentTimer;
  bool get isRunning => _timerRunning;
  int get workSessionsCompletedToday => _workSessionsCompletedToday;

  incrementWorkSessionsCompleted() {
    _workSessionsCompletedToday++;
    _updateStateToDatabase();
    notifyListeners();
  }

  /* set isRunning(bool val) {
    _timerRunning = val;
    timerStartedAt = DateTime.now();
    notifyListeners();
  } */

  set project(Project project) {
    _project = project;
    _currentTimer = PomoTimer(
      timerDuration: TimerDuration(
        work: project.workDuration,
      ),
    );
    _updateStateToDatabase();
    notifyListeners();
  }

  set setUser(User upuser) {
    if(upuser != null){
      user = upuser;
      initWorkLogDBS(user.id);
      _loadFromDatabase();
      loadTimerFromPrefs();
    }
  }

  set currentTimer(PomoTimer timer) {
    _currentTimer = timer;
    _updateStateToDatabase();
    notifyListeners();
  }

  timerSessionsFromSettings(PomoTimer timer) {
    _currentTimer = timer;
    notifyListeners();
  }

  timerStarted(Duration duration) {
    setAlarm(duration, alarmCallback);
    _timerRunning = true;
    timerStartedAt = DateTime.now();
    _saveTimerToPrefs();
    notifyListeners();
  }

  workComplete() {
    _workSessionsCompletedToday++;
    timerStartedAt = null;
    _timerRunning = false;
    elapsed = Duration.zero;
    _clearTimerFromPrefs();
    player.play("work-alarm.mp3");
    WorkLog log = WorkLog(
      date: DateTime.now(),
      duration: _currentTimer.timerDuration.work,
      project: _project,
    );
    logDBS.createItem(log);
    _currentTimer = PomoTimer(
      timerDuration: _currentTimer.timerDuration,
      timerType:
          _workSessionsCompletedToday % user.setting.sessionsBeforeLongBreak ==
                  0
              ? TimerType.LONG_BREAK
              : TimerType.BREAK,
    );
    _updateStateToDatabase();
    notifyListeners();
  }

  workCanceled() {
    elapsed = Duration.zero;
    timerStartedAt = null;
    _timerRunning = false;
    _clearTimerFromPrefs();
    cancelAlarm();
    notifyListeners();
  }

  breakComplete() {
    elapsed = Duration.zero;
    timerStartedAt = null;
    player.play("break-alarm.mp3");
    _timerRunning = false;
    _clearTimerFromPrefs();
    _breakOver();
  }

  breakCanceled() {
    elapsed = Duration.zero;
    timerStartedAt = null;
    _timerRunning = false;
    _clearTimerFromPrefs();
    _breakOver();
    cancelAlarm();
  }

  setAlarm(Duration delay, Function callback) async {
    prefs.setString("notification_title", "${timerTypeToString(_currentTimer.timerType)} session completed.");
    prefs.setString("notification_details", "Your ${timerTypeToString(_currentTimer.timerType)} session has successfully completed.");
    await AndroidAlarmManager.oneShot(delay, alarmId, callback,
        alarmClock: true, exact: true,wakeup: true);
  }

  cancelAlarm() async {
    await AndroidAlarmManager.cancel(alarmId);
  }

  _breakOver() {
    _currentTimer = PomoTimer(
      timerDuration: _currentTimer.timerDuration,
      timerType: TimerType.WORK,
    );
    _updateStateToDatabase();
    notifyListeners();
  }

  TimerState({this.user}) {
    print("--init timer state--");
    player.loadAll(["work-alarm.mp3", "break-alarm.mp3"]);
    _timerRunning = false;
    elapsed = Duration.zero;
    _currentTimer = PomoTimer(
        timerDuration: TimerDuration(
      work: Duration(seconds: 10),
      shortBreak: Duration(seconds: 2),
      longBreak: Duration(seconds: 5),
    ));
    _today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _workSessionsCompletedToday = 0;
    _loadFromDatabase();
    _initSharedPrefs();
  }

  _initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    loadTimerFromPrefs();
  }

  void loadTimerFromPrefs() {
    if (user == null) return;
    String tm = prefs.getString(timerKey);
    if (tm == null) return;
    Map<String, dynamic> tms = json.decode(tm);
    DateTime startedAt = DateTime.fromMillisecondsSinceEpoch(tms["started_at"]);
    TimerType type = stringToTimerType(tms["timer_type"]);
    Duration rtd = Duration(minutes: tms["duration"]);
    print(DateTime.now());
    print(startedAt);
    print("difference: " +
        DateTime.now().difference(startedAt).inSeconds.toString());
    print("total duration: " + rtd.inSeconds.toString());
    Duration el = DateTime.now().difference(startedAt);
    if (el.inSeconds < rtd.inSeconds) {
      timerStartedAt = startedAt;
      elapsed = el;
      _currentTimer = PomoTimer(
        timerDuration: currentTimer.timerDuration,
        timerType: type,
      );
      _timerRunning = true;
      notifyListeners();
    } else {
      if (type == TimerType.WORK)
        workComplete();
      else
        breakComplete();
    }
  }

  Future<bool> _saveTimerToPrefs() async {
    Map<String, dynamic> tms = {
      "duration": durationByTimerType(
              currentTimer.timerType, currentTimer.timerDuration)
          .inMinutes,
      "started_at": timerStartedAt.millisecondsSinceEpoch,
      "timer_type": timerTypeToString(currentTimer.timerType),
    };
    return await prefs.setString(timerKey, json.encode(tms));
  }

  _clearTimerFromPrefs() async {
    await prefs.remove(timerKey);
  }

  _loadFromDatabase() {
    if (user == null) return;
    if (user.savedState.isNotEmpty) {
      _currentTimer = PomoTimer(
        timerDuration: TimerDuration(
          work: Duration(minutes: user.savedState["work_duration"]),
          shortBreak: user.setting.shortBreak,
          longBreak: user.setting.longBreak,
        ),
        timerType: stringToTimerType(user.savedState["timer_type"]),
      );
      if (_today == user.savedState["date"]?.toDate()) {
        _workSessionsCompletedToday =
            user.savedState["work_sessions_completed_today"];
      }
      _project = Project.fromDS(user.savedState["project_id"],
          Map<String, dynamic>.from(user.savedState["project"] ?? {}));
    }
  }

  _updateStateToDatabase() {
    if (user == null) return;
    User updated = User(
        name: user.name,
        email: user.email,
        id: user.id,
        setting: user.setting,
        savedState: <String, dynamic>{
          "work_duration": _currentTimer.timerDuration.work.inMinutes,
          "timer_type": timerTypeToString(_currentTimer.timerType),
          "project_id": _project?.id,
          "project": _project?.toMap(),
          "date": _today,
          "work_sessions_completed_today": _workSessionsCompletedToday,
        });
    userDBS.updateItem(updated);
  }
}
