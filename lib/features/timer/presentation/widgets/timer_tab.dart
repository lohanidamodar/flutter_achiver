import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/timer/presentation/model/pomo_timer_model.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:flutter_achiver/features/timer/presentation/widgets/timer.dart';
import 'package:provider/provider.dart';

class TimerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerState>(
      builder: (context, state, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              BorderedContainer(
                child: Column(
                  children: <Widget>[
                    CDTimer(
                      project: state.project,
                      timer: state.currentTimer,
                      workComplete: () { 
                        print("--work complete--");
                        state.currentTimer = PomoTimer(
                          timerDuration: state.currentTimer.timerDuration,
                          timerType: TimerType.BREAK,
                        );
                      },
                      workCanceled: () {
                        print("--work canceled--");
                      },
                      breakComplete: () {
                        print("--break complete/canceled/skip--");
                        state.currentTimer = PomoTimer(
                          timerDuration: state.currentTimer.timerDuration,
                          timerType: TimerType.WORK,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              BorderedContainer(
                child: Column(
                  children: <Widget>[
                    Text("Current Project"),
                    Text(state.project != null
                        ? state.project.title
                        : "No project selected"),
                    Text("work sessions completed today"),
                    Text("Daily average (Last 7 Days)"),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
