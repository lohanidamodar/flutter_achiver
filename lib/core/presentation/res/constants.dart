import 'package:flutter_achiver/core/presentation/res/assets.dart';

const List<Duration> durations = [
  Duration(minutes: 5),
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
    switch(type) {
      case TimerType.BREAK:
        return "Short Break";
      case TimerType.LONG_BREAK:
        return "Long Break";
      case TimerType.WORK:
      default:
        return "Work";
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
