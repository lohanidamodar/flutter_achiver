import 'package:flutter_achiver/core/data/res/constants.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/features/auth/data/model/user.dart';

DatabaseService<User> userDBS = DatabaseService<User>(USERS_COLLECTION,fromDS: (id,data) => User.fromDS(id, data),toMap: (user) => user.toMap());
