import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/assets.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text("Projects"),
            leading: Image.asset(projectsIcon),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
            onTap: () => Provider.of<UserRepository>(context).signOut(),
          )
        ],
      ),
    );
  }
}

