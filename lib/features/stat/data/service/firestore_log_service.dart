import 'package:flutter_achiver/core/data/res/constants.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';

DatabaseService<WorkLog> logDBS;
initWorkLogDBS(String uid) {
  if(uid == null) return null;
  if(logDBS == null)
    logDBS = DatabaseService<WorkLog>("users/$uid/$LOGS_COLLECTION",fromDS: (id,data) => WorkLog.fromDS(id, data),toMap: (log) => log.toMap());
} 
