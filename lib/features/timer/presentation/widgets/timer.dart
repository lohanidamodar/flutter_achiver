import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'dart:async';

import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';

class CDTimer extends StatefulWidget {
  final PomoTimer timer;
  final Project project;
  final Function breakComplete;
  final Function workComplete;
  final Function workCanceled;

  CDTimer(
      {Key key,
      @required this.timer,
      this.project,
      @required this.breakComplete,
      @required this.workCanceled,
      @required this.workComplete})
      : super(key: key);

  @override
  _CDTimerState createState() => _CDTimerState();
}

class _CDTimerState extends State<CDTimer> with SingleTickerProviderStateMixin {
  Timer timer;

  /// Store the time
  /// You will pass the minutes.
  String timeText = '';
  String statusText = '';

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(microseconds: 1);

  /// for animation
  var begin = 0.0;
  Animation<double> heightSize;
  AnimationController _controller;

  /// Called each time the time is ticking
  void updateClock() {
    final duration = durationByTimerType(widget.timer.timerType);

    // if time is up, stop the timer
    if (stopwatch.elapsed.inMilliseconds == duration.inMilliseconds) {
      print('--finished Timer Page--');
      stopwatch.stop();
      stopwatch.reset();
      _controller.stop(canceled: false);
      widget.timer.timerType == TimerType.WORK
          ? widget.workComplete()
          : widget.breakComplete();
      setState(() {
        statusText = 'Finished';
      });
      return;
    }

    final millisecondsRemaining =
        duration.inMilliseconds - stopwatch.elapsed.inMilliseconds;
    final hoursRemaining =
        ((millisecondsRemaining / (1000 * 60 * 60)) % 24).toInt();
    final minutesRemaining =
        ((millisecondsRemaining / (1000 * 60)) % 60).toInt();
    final secondsRemaining = ((millisecondsRemaining / 1000) % 60).toInt();

    setState(() {
      timeText = '${hoursRemaining.toString().padLeft(2, '0')}:'
          '${minutesRemaining.toString().padLeft(2, '0')}:'
          '${secondsRemaining.toString().padLeft(2, '0')}';
    });
  }

  Duration durationByTimerType(TimerType type) {
    switch (type) {
      case TimerType.BREAK:
        return widget.timer.timerDuration.shortBreak;
      case TimerType.LONG_BREAK:
        return widget.timer.timerDuration.longBreak;
      case TimerType.WORK:
      default:
        return widget.timer.timerDuration.work;
    }
  }

  /* String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  } */

  @override
  void initState() {
    super.initState();
    final duration = durationByTimerType(widget.timer.timerType);
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    timer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void dispose() {
    _controller.dispose();
    stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  void _restartCountDown() {
    begin = 0.0;
    _controller.reset();
    stopwatch.stop();
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    /* heightSize =
        new Tween(begin: begin, end: MediaQuery.of(context).size.height - 65)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    ); */

    return Container(
      child: Column(
        children: <Widget>[
          Text("Motivation Text"),
          if (stopwatch.isRunning) ...[
            Text(
              timeText,
              style: TextStyle(fontSize: 54.0, color: Colors.black),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _restartCountDown();
                if (widget.timer.timerType == TimerType.WORK) {
                  widget.workCanceled();
                } else {
                  widget.breakComplete();
                }
              },
            ),
          ],
          if (!stopwatch.isRunning)
            OutlineButton(
              child: Text(widget.timer.timerType == TimerType.WORK
                  ? "Start Work Session"
                  : "Take a Break"),
              onPressed: () {
                print('--Running--');
                begin = 50.0;
                stopwatch.start();
                _controller.forward();
                updateClock();
              },
            ),
          if (widget.timer.timerType != TimerType.WORK && !stopwatch.isRunning)
            OutlineButton(
              child: Text("Skip Break"),
              onPressed: () {
                _restartCountDown();
                widget.breakComplete();
              },
            ),
        ],
      ),
    );
  }
}
