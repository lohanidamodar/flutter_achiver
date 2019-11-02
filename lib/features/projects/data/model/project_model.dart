import 'package:flutter_achiver/core/data/model/database_item.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';

class Project extends DatabaseItem {
  final String title;
  final String id;
  final ProjectStatus status;
  final Duration workDuration;
  final int sessionsBeforeLongBreak;

  Project({this.title, this.id, this.status, this.workDuration, this.sessionsBeforeLongBreak}):super(id);
  
  Project.fromDS(String id, Map<String,dynamic> data):
    id= id,
    title=data["title"],
    status=stringToStatus(data["status"]),
    workDuration=Duration(minutes: data["work_duration"] ?? 0),
    sessionsBeforeLongBreak=data["sessions_before_long_break"],
    super(id);
  
  Map<String,dynamic> toMap() => {
    "title":title,
    "status":statusToString(status),
    "work_duration":workDuration?.inMinutes,
    "sessions_before_long_break":sessionsBeforeLongBreak,
  };
}

