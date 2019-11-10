import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/core/presentation/res/functions.dart';
import 'package:flutter_achiver/core/presentation/res/styles.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';
import 'package:flutter_achiver/features/stat/res/constants.dart';

import 'stats_block.dart';

class StatsFromLogs extends StatefulWidget {
  final List<WorkLog> logs;
  final ChartTimeType chartTimeType;
  final bool showProjects;
  const StatsFromLogs(
      {Key key,
      @required this.logs,
      this.chartTimeType = ChartTimeType.WEEKLY,
      this.showProjects = true})
      : super(key: key);

  @override
  _StatsFromLogsState createState() => _StatsFromLogsState();
}

class _StatsFromLogsState extends State<StatsFromLogs> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(StatsFromLogs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.logs != widget.logs) calculateStats();
  }

  Duration totalTimeSpent;
  Map<int, Duration> timeSpentByDays;
  Map<String, Duration> timeSpentByProjects;
  @override
  void initState() {
    super.initState();
    calculateStats();
  }

  calculateStats() {
    totalTimeSpent = Duration.zero;
    timeSpentByDays = <int, Duration>{
      1: Duration.zero,
      2: Duration.zero,
      3: Duration.zero,
      4: Duration.zero,
      5: Duration.zero,
      6: Duration.zero,
      7: Duration.zero,
    };
    timeSpentByProjects = {};
    widget.logs.forEach((lg) {
      totalTimeSpent += lg.duration;
      timeSpentByDays[lg.date.weekday] += lg.duration;
      if (timeSpentByProjects[lg.project.title] == null)
        timeSpentByProjects[lg.project.title] = lg.duration;
      else
        timeSpentByProjects[lg.project.title] += lg.duration;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.logs.length < 1)
      return Container(
        child: Text("Sorry no records found"),
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          TextSpan(children: [
            TextSpan(text: "You have completed "),
            TextSpan(text: "${widget.logs.length}", style: boldText),
            TextSpan(text: " work sessions during this period. Awesome job!")
          ]),
        ),
        const SizedBox(height: 10.0),
        BorderedContainer(
          padding: const EdgeInsets.all(8.0),
          color: Colors.pink.shade400,
          child: Row(
            children: <Widget>[
              Text(
                "Total time worked",
                style: boldText.copyWith(color: Colors.white70),
              ),
              Spacer(),
              const SizedBox(width: 10.0),
              StatsBlock(
                child: Text(
                  "${durationToHMString(totalTimeSpent)}",
                  style: titleStyle,
                ),
              ),
            ],
          ),
        ),
        if (!isDaily(widget.chartTimeType)) ...[
          const SizedBox(height: 10.0),
          Text("Time worked by day of the week"),
          _buildStatByDays(context),
        ],
        if (widget.showProjects) ...[
          const SizedBox(height: 10.0),
          Text("Projects worked on"),
          _buildStatByProjects(context),
        ],
      ],
    );
  }

  BorderedContainer _buildStatByDays(BuildContext context) {
    return BorderedContainer(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ...[1, 2, 3, 4, 5, 6, 7].map(
            (day) => Stack(
              children: <Widget>[
                BorderedContainer(
                  color: Theme.of(context).primaryColor,
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.pink.shade300,
                  ),
                  width: timeSpentByDays[day].inSeconds > 0
                      ? MediaQuery.of(context).size.width *
                          (timeSpentByDays[day].inSeconds /
                              totalTimeSpent.inSeconds)
                      : 0,
                  padding: const EdgeInsets.all(16.0),
                  duration: Duration(milliseconds: 200),
                ),
                BorderedContainer(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(0.0),
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Text(days[day]),
                      Spacer(),
                      Text(
                        "${durationToHMString(timeSpentByDays[day])}",
                        style: boldText,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 40.0,
                        child: Text(
                          "${(timeSpentByDays[day].inSeconds / totalTimeSpent.inSeconds * 100).toStringAsFixed(0)}%",
                          textAlign: TextAlign.right,
                          style: boldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BorderedContainer _buildStatByProjects(BuildContext context) {
    return BorderedContainer(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ...timeSpentByProjects.keys.map(
            (project) => Stack(
              children: <Widget>[
                BorderedContainer(
                  color: Theme.of(context).primaryColor,
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.pink.shade300,
                  ),
                  width: timeSpentByProjects[project].inSeconds > 0
                      ? MediaQuery.of(context).size.width *
                          (timeSpentByProjects[project].inSeconds /
                              totalTimeSpent.inSeconds)
                      : 0,
                  padding: const EdgeInsets.all(16.0),
                  duration: Duration(milliseconds: 200),
                ),
                BorderedContainer(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(0.0),
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Text(project),
                      Spacer(),
                      Text(
                        "${durationToHMString(timeSpentByProjects[project])}",
                        style: boldText,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 40.0,
                        child: Text(
                          "${(timeSpentByProjects[project].inSeconds / totalTimeSpent.inSeconds * 100).toStringAsFixed(0)}%",
                          textAlign: TextAlign.right,
                          style: boldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
