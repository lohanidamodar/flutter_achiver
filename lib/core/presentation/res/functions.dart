String durationToHMString(Duration duration) {
  final millisecondsRemaining =
        duration.inMilliseconds;
    final hoursRemaining =
        ((millisecondsRemaining / (1000 * 60 * 60)) % 24).toInt();
    final minutesRemaining =
        ((millisecondsRemaining / (1000 * 60)) % 60).toInt();
    
    return '${hoursRemaining}h ${minutesRemaining}m';
}