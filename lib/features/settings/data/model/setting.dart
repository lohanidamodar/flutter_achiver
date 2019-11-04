class Setting {
  final Duration work;
  final Duration shortBreak;
  final Duration longBreak;
  final int sessionsBeforeLongBreak;

  const Setting({
    this.work = const Duration(minutes: 25),
    this.shortBreak = const Duration(minutes: 5),
    this.longBreak = const Duration(minutes: 15),
    this.sessionsBeforeLongBreak = 4,
  });

  Setting.fromMap(Map<String, dynamic> data)
      : work = Duration(minutes: data["work_duration"] ?? 25),
        shortBreak = Duration(minutes: data["short_break"] ?? 5),
        longBreak = Duration(minutes: data["long_break"] ?? 15),
        sessionsBeforeLongBreak = data["sessions_before_long_break"];

  Map<String, dynamic> toMap() => {
        "work_duration": work?.inMinutes,
        "short_break": shortBreak?.inMinutes,
        "long_break": longBreak?.inMinutes,
        "sessions_before_long_break": sessionsBeforeLongBreak,
      };
}
