import 'package:flutter/foundation.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/auth/data/model/user.dart';
import 'package:flutter_achiver/features/auth/data/service/firestore_user_service.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';
import 'package:flutter_achiver/features/timer/presentation/model/timer_durations_model.dart';

class TimerState extends ChangeNotifier {
  final String uid;
  final User user;
  Project _project;
  PomoTimer _currentTimer;
  bool _timerRunning;
  DateTime _today;
  int _workSessionsCompletedToday;

  Project get project => _project;
  PomoTimer get currentTimer => _currentTimer;
  bool get isRunning => _timerRunning;
  int get workSessionsCompletedToday => _workSessionsCompletedToday;

  incrementWorkSessionsCompleted() {
    _workSessionsCompletedToday++;
    _updateStateToDatabase();
    notifyListeners();
  }

  set isRunning(bool val) {
    _timerRunning = val;
    notifyListeners();
  }

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

  set currentTimer(PomoTimer timer) {
    _currentTimer = timer;
    _updateStateToDatabase();
    notifyListeners();
  }

  workComplete() {
    _workSessionsCompletedToday++;
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

  breakComplete() {
    _currentTimer = PomoTimer(
      timerDuration: _currentTimer.timerDuration,
      timerType: TimerType.WORK,
    );
    _updateStateToDatabase();
    notifyListeners();
  }

  TimerState({this.user, this.uid}) {
    _timerRunning = false;
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
  }

  _loadFromDatabase() {
    if (user == null) return;
    //TODO load from firestore
    if (user.savedState.isNotEmpty) {
      _currentTimer = PomoTimer(
        timerDuration: TimerDuration(
          work: Duration(minutes: user.savedState["work_duration"]),
          shortBreak: Duration(minutes: user.savedState["short_break"]),
          longBreak: Duration(minutes: user.savedState["long_break"]),
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
    //TODO save to firestore
    User updated = User(
        name: user.name,
        email: user.email,
        id: user.id,
        setting: user.setting,
        savedState: <String, dynamic>{
          "work_duration": _currentTimer.timerDuration.work.inMinutes,
          "short_break": _currentTimer.timerDuration.shortBreak.inMinutes,
          "long_break": _currentTimer.timerDuration.longBreak.inMinutes,
          "timer_type": timerTypeToString(_currentTimer.timerType),
          "project_id": _project?.id,
          "project": _project?.toMap(),
          "date": _today,
          "work_sessions_completed_today": _workSessionsCompletedToday,
        });
    userDBS.updateItem(updated);
  }
}
