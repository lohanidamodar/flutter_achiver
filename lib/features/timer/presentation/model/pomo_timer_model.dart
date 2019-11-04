import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'timer_durations_model.dart';

class PomoTimer {
  final TimerDuration timerDuration;
  final TimerType timerType;

  const PomoTimer({this.timerDuration = const TimerDuration(), this.timerType = TimerType.WORK});
}
