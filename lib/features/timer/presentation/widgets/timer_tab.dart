import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/functions.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/project_dropdown.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:flutter_achiver/features/timer/presentation/widgets/timer.dart';
import 'package:provider/provider.dart';

class TimerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerState>(
      builder: (context, state, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BorderedContainer(
                child: Column(
                  children: <Widget>[
                    CDTimer(
                      project: state.project,
                      timer: state.currentTimer,
                      workComplete: state.workComplete,
                      workCanceled: state.workCanceled,
                      timerStarted: state.timerStarted,
                      breakCanceled: state.breakCanceled,
                      breakComplete: state.breakComplete,
                      isRunning: state.isRunning,
                      elapsed: state.elapsed,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text("Selected project"),
              const SizedBox(height: 5.0),
              BorderedContainer(
                padding: const EdgeInsets.all(0),
                child: ProjectDropdown(
                  disabled: state.isRunning,
                  label: "Project",
                  initialProject: state.project,
                  onSelectProject: (project) {
                    state.project = project;
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              BorderedContainer(
                padding: const EdgeInsets.all(0),
                child: ListTile(
                      title: Text("work sessions completed today"),
                      trailing: Text("${state.workSessionsCompletedToday}"),
                    ),
              ),
              BorderedContainer(
                padding: const EdgeInsets.all(0),
                child: FutureBuilder(
                    future: logDBS.getListFromTo('date', beginingOfDay(DateTime(today.year,today.month,today.day-6)), endOfDay(today)),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        title: Text("Daily average (Last 7 Days)"),
                        trailing: !snapshot.hasData ? Text("N/A") : Text((snapshot.data.length / 7).toInt().toString()),
                      );
                    },
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}
