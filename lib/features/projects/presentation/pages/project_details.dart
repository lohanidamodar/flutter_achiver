import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/core/presentation/res/functions.dart';
import 'package:flutter_achiver/core/presentation/res/styles.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:date_utils/date_utils.dart';
import 'package:flutter_achiver/features/stat/presentation/widgets/stats_block.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({Key key, this.project}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  List<WorkLog> logs;
  Duration totalTimeSpent;
  Map<int, Duration> timeSpentByDays;
  @override
  void initState() {
    super.initState();
    logs = [];
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
    getStats();
  }

  getStats() async {
    List<WorkLog> lg = await logDBS.getListFromTo(
        'date', Utils.previousMonth(DateTime.now()), DateTime.now(),
        args: [QueryArgs("project_id", widget.project.id)]);
    setState(() {
      logs = lg;
    });
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
    logs.forEach((lg) {
      totalTimeSpent += lg.duration;
      timeSpentByDays[lg.date.weekday] += lg.duration;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BorderedContainer(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).accentColor,
              child: Row(
                children: <Widget>[
                  Text(
                    "Total time spent",
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
            ...[1, 2, 3, 4, 5, 6, 7].map((day) => BorderedContainer(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(days[day]),
                      Spacer(),
                      StatsBlock(
                        width: 80,
                        child: Center(
                          child: Text(
                            "${durationToHMString(timeSpentByDays[day])}",
                            style: boldText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      StatsBlock(
                        width: 60,
                        child: Center(
                          child: Text(
                            "${(timeSpentByDays[day].inSeconds / totalTimeSpent.inSeconds * 100).toStringAsFixed(1)}%",
                            style: boldText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
