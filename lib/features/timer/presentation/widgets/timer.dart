import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'dart:async';
import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:provider/provider.dart';

class CDTimer extends StatefulWidget {
  final PomoTimer timer;
  final Project project;
  final Function breakComplete;
  final Function breakCanceled;
  final Function workComplete;
  final Function workCanceled;
  final Function(Duration) timerStarted;
  final bool isRunning;
  final Duration elapsed;

  CDTimer({
    Key key,
    @required this.timer,
    this.project,
    @required this.breakComplete,
    @required this.breakCanceled,
    @required this.workCanceled,
    @required this.workComplete,
    this.timerStarted,
    this.isRunning = false,
    this.elapsed = Duration.zero,
  }) : super(key: key);

  @override
  _CDTimerState createState() => _CDTimerState();
}

class _CDTimerState extends State<CDTimer>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
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
    final duration = Duration(
        milliseconds: durationByTimerType(
                    widget.timer.timerType, widget.timer.timerDuration)
                .inMilliseconds -
            widget.elapsed.inMilliseconds);

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final duration =
        durationByTimerType(widget.timer.timerType, widget.timer.timerDuration);
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    timer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.resumed) {
      TimerState state = Provider.of<TimerState>(context);
      state.loadTimerFromPrefs();
    }
    print(Provider.of<TimerState>(context).isRunning
        ? "Save timer"
        : "not running");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    if (widget.isRunning && !stopwatch.isRunning) stopwatch.start();

    return Container(
      child: Column(
        children: <Widget>[
          if (widget.isRunning) ...[
            Text(
              timeText,
              style: TextStyle(fontSize: 54.0),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _restartCountDown();
                if (widget.timer.timerType == TimerType.WORK) {
                  widget.workCanceled();
                } else {
                  widget.breakCanceled();
                }
              },
            ),
          ],
          if (!widget.isRunning)
            SizedBox(
              width: 160.0,
              child: OutlineButton(
                child: Text(widget.timer.timerType == TimerType.WORK
                    ? "Start Work Session"
                    : "Take a Break"),
                onPressed: () {
                  print('--Running--');
                  begin = 50.0;
                  stopwatch.start();
                  if (widget.timerStarted != null)
                    widget.timerStarted(durationByTimerType(
                        widget.timer.timerType, widget.timer.timerDuration));
                  _controller.forward();
                  updateClock();
                },
              ),
            ),
          if (widget.timer.timerType != TimerType.WORK && !stopwatch.isRunning)
            SizedBox(
              width: 160.0,
              child: OutlineButton(
                child: Text("Skip Break"),
                onPressed: () {
                  _restartCountDown();
                  widget.breakCanceled();
                },
              ),
            ),
        ],
      ),
    );
  }
}
