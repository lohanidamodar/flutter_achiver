import 'package:flutter_achiver/core/presentation/res/assets.dart';
import 'package:flutter_achiver/features/timer/presentation/model/timer_durations_model.dart';

const List<Duration> durations = [
  Duration(minutes: 1),
  Duration(minutes: 10),
  Duration(minutes: 15),
  Duration(minutes: 20),
  Duration(minutes: 25),
  Duration(minutes: 30),
  Duration(minutes: 35),
  Duration(minutes: 40),
  Duration(minutes: 45),
  Duration(minutes: 50),
  Duration(minutes: 52),
  Duration(minutes: 55),
  Duration(minutes: 60),
  Duration(minutes: 75),
  Duration(minutes: 90),
  Duration(minutes: 120),
  Duration(minutes: 150),
  Duration(minutes: 180),
];
const List<Duration> longBreakDurations = [
  Duration(minutes: 1),
  Duration(minutes: 10),
  Duration(minutes: 15),
  Duration(minutes: 17),
  Duration(minutes: 20),
  Duration(minutes: 25),
  Duration(minutes: 30),
  Duration(minutes: 35),
  Duration(minutes: 40),
  Duration(minutes: 45),
  Duration(minutes: 50),
  Duration(minutes: 60),
];
const List<Duration> shortBreakDurations = [
  Duration(minutes: 1),
  Duration(minutes: 2),
  Duration(minutes: 3),
  Duration(minutes: 4),
  Duration(minutes: 5),
  Duration(minutes: 6),
  Duration(minutes: 7),
  Duration(minutes: 8),
  Duration(minutes: 9),
  Duration(minutes: 10),
  Duration(minutes: 12),
  Duration(minutes: 15),
  Duration(minutes: 17),
  Duration(minutes: 20),
];

enum TimerType {
  WORK,
  BREAK,
  LONG_BREAK,
}

enum ProjectStatus {
  ONGOING,
  SUSPENDED,
  COMPLETED,
}

String timerTypeToString(TimerType type) {
  switch (type) {
    case TimerType.BREAK:
      return "Short Break";
    case TimerType.LONG_BREAK:
      return "Long Break";
    case TimerType.WORK:
    default:
      return "Work";
  }
}

TimerType stringToTimerType(String type) {
  switch (type) {
    case "Short Break":
      return TimerType.BREAK;
    case "Long Break":
      return TimerType.LONG_BREAK;
    case "Work":
    default:
      return TimerType.WORK;
  }
}

String statusToIcon(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.ONGOING:
      return projectOngoingIcon;
    case ProjectStatus.COMPLETED:
      return projectCompleteIcon;
    case ProjectStatus.SUSPENDED:
      return projectSuspendedIcon;
    default:
      return projectOngoingIcon;
  }
}

String statusToString(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.ONGOING:
      return "Ongoing";
    case ProjectStatus.COMPLETED:
      return "Completed";
    case ProjectStatus.SUSPENDED:
      return "Suspended";
    default:
      return "Ongoing";
  }
}

ProjectStatus stringToStatus(String status) {
  switch (status) {
    case "Ongoing":
      return ProjectStatus.ONGOING;
    case "Completed":
      return ProjectStatus.COMPLETED;
    case "Suspended":
      return ProjectStatus.SUSPENDED;
    default:
      return ProjectStatus.ONGOING;
  }
}

Duration durationByTimerType(TimerType type, TimerDuration timer) {
    switch (type) {
      case TimerType.BREAK:
        return timer.shortBreak;
      case TimerType.LONG_BREAK:
        return timer.longBreak;
      case TimerType.WORK:
      default:
        return timer.work;
    }
  }
