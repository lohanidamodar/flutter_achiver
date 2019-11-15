String durationToHMString(Duration duration) {
  final millisecondsRemaining =
        duration.inMilliseconds;
    final hoursRemaining =
        ((millisecondsRemaining ~/ (1000 * 60 * 60))).toInt();
    final minutesRemaining =
        ((millisecondsRemaining / (1000 * 60)) % 60).toInt();
    return '${hoursRemaining}h ${minutesRemaining}m';
}

final DateTime _today = dayFromDate(DateTime.now());
DateTime get today=> _today;
DateTime dayFromDate(date) => DateTime(date.year,date.month,date.day);

DateTime addDay(date, days) => DateTime(date.year,date.month,date.day + days);
DateTime subDay(date, days) => DateTime(date.year,date.month,date.day - days);

DateTime firstDayOfYear(date) => DateTime(date.year, 1, 1);
DateTime lastDayOfYear(date) => DateTime(date.year, 12, 31);
DateTime nextYear(date) => DateTime(date.year+1, date.month, date.day);
DateTime prevYear(date) => DateTime(date.year-1, date.month, date.day);
DateTime prevDay(date) => DateTime(date.year, date.month, date.day-1);
DateTime nextDay(date) => DateTime(date.year, date.month, date.day+1);
DateTime beginingOfDay(date) => DateTime(date.year,date.month,date.day,0,0,0);
DateTime endOfDay(date) => DateTime(date.year,date.month,date.day,23,59,59);