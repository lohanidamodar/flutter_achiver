import 'package:flutter/foundation.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';
import 'package:flutter_achiver/features/timer/presentation/model/timer_durations_model.dart';

class TimerState extends ChangeNotifier {
  Project _project;
  TimerDuration _timerDuration;
  PomoTimer _currentTimer;
  bool _timerRunning;

  Project get project => _project;
  TimerDuration get timerDuration => _timerDuration;
  PomoTimer get currentTimer => _currentTimer;
  bool get isRunning => _timerRunning;

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
    notifyListeners();
  }

  set timerDuration(TimerDuration timer) {
    _timerDuration = timer;
    notifyListeners();
  }

  set currentTimer(PomoTimer timer) {
    _currentTimer = timer;
    notifyListeners();
  }

  TimerState() {
    _timerRunning = false;
    _currentTimer = PomoTimer(
        timerDuration: TimerDuration(
      work: Duration(seconds: 10),
      shortBreak: Duration(seconds: 2),
      longBreak: Duration(seconds: 5),
    ));
  }
}
