import 'package:flutter_achiver/core/data/res/constants.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';

DatabaseService<Project> projectDBS;
initProjectDBS(String uid) {
  if(uid == null) return null;
  if(projectDBS == null);
    projectDBS = DatabaseService<Project>("users/$uid/$PROJECTS_COLLECTION",fromDS: (id,data) => Project.fromDS(id, data),toMap: (project) => project.toMap());
} 
