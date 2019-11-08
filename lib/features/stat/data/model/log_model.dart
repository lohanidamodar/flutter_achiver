import 'package:flutter_achiver/core/data/model/database_item.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';

class WorkLog extends DatabaseItem{
  final DateTime date;
  final Project project;
  final Duration duration;
  final String id;

  WorkLog({this.date, this.project, this.duration,this.id}):super(id);

  WorkLog.fromDS(String id, Map<String,dynamic> data):
    id=id,
    project=Project.fromDS(data["project_id"], Map<String,dynamic>.from(data["project"])),
    duration=Duration(minutes: data["duration"] ?? 0),
    date=data["date"]?.toDate(),
    super(id);

  Map<String,dynamic> toMap() => {
    "project_id": project?.id,
    "project": project?.toMap(),
    "duration": duration?.inMinutes,
    "date": date,
  };

}