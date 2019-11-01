import 'package:flutter_achiver/core/data/res/constants.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';

DatabaseService<Project> projectDBS = DatabaseService<Project>(PROJECTS_COLLECTION,fromDS: (id,data) => Project.fromDS(id, data),toMap: (project) => project.toMap());
