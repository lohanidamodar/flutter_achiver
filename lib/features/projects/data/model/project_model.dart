import 'package:flutter_achiver/core/presentation/res/constants.dart';

class Project {
  final String title;
  final String id;
  final ProjectStatus status;
  final Duration workDuration;
  final int sessionsBeforeLongBreak;

  Project({this.title, this.id, this.status, this.workDuration, this.sessionsBeforeLongBreak});
  
  Project.fromDS(String id, Map<String,dynamic> data):
    id= id,
    title=data["title"],
    status=stringToStatus(data["status"]),
    workDuration=Duration(minutes: data["work_duration"]),
    sessionsBeforeLongBreak=data["sessions_before_long_break"];
}

