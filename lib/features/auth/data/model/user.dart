import 'package:flutter_achiver/core/data/model/database_item.dart';
import 'package:flutter_achiver/features/settings/data/model/setting.dart';

class User extends DatabaseItem {
  final String id;
  final String name;
  final String email;
  final Setting setting;
  final Map<String, dynamic> savedState;

  User({
    this.name,
    this.email,
    this.setting = const Setting(),
    this.savedState = const {},
    this.id,
  }) : super(id);

  User.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        name = data["name"],
        email = data["email"],
        setting = Setting.fromMap(Map<String,dynamic>.from(data["setting"] ?? {})),
        savedState = Map<String,dynamic>.from( data["saved_state"] ?? {}),
        super(id);

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "setting": setting.toMap(),
        "saved_state": savedState,
      };
}
