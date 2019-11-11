import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';

class LogListPage extends StatelessWidget {
  final List<WorkLog> logs;

  const LogListPage({Key key, @required this.logs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          WorkLog log = logs[index];
          return ListTile(
            title: Text(log.project.title),
            subtitle: Text(Utils.fullDayFormat(log.date)),
          );
        },
      ),
    );
  }
}
