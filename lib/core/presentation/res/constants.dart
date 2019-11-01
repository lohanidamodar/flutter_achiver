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
