class TimerDuration {
  final Duration work;
  final Duration shortBreak;
  final Duration longBreak;

  const TimerDuration({this.work = const Duration(minutes: 25), this.shortBreak = const Duration(minutes: 5), this.longBreak = const Duration(minutes: 15)});
}