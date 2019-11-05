import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/core/presentation/res/styles.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/auth/data/model/user.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:flutter_achiver/features/settings/data/model/setting.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  Duration _workDuration;
  Duration _shortBreak;
  Duration _longBreak;
  int _longBreakInterval;
  bool loaded;
  bool processing;
  @override
  void initState() { 
    super.initState();
    loaded = false;
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepository>(
      builder: (context, user,child) {
        if(!loaded) {
          Setting setting = user.fsUser?.setting;
          _workDuration = setting?.work;
          _shortBreak = setting?.shortBreak;
          _longBreak = setting?.longBreak;
          _longBreakInterval = setting?.sessionsBeforeLongBreak;
          loaded = true;
        }
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text(
              "Work session duration",
              style: labelStyle,
            ),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton<Duration>(
                initialValue: _workDuration,
                child: ListTile(
                  title: Text("${_workDuration?.inMinutes} minutes"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
                itemBuilder: (context) {
                  return [
                    ...durations.map(
                      (duration) => PopupMenuItem(
                        value: duration,
                        child: Text("${duration.inMinutes} minutes"),
                      ),
                    )
                  ];
                },
                onSelected: (duration) {
                  setState(() {
                    _workDuration = duration;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Short Break duration",
              style: labelStyle,
            ),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton<Duration>(
                initialValue: _shortBreak,
                child: ListTile(
                  title: Text("${_shortBreak?.inMinutes} minutes"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
                itemBuilder: (context) {
                  return [
                    ...shortBreakDurations.map(
                      (duration) => PopupMenuItem(
                        value: duration,
                        child: Text("${duration.inMinutes} minutes"),
                      ),
                    )
                  ];
                },
                onSelected: (duration) {
                  setState(() {
                    _shortBreak = duration;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Long Break duration",
              style: labelStyle,
            ),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton<Duration>(
                initialValue: _longBreak,
                child: ListTile(
                  title: Text("${_longBreak?.inMinutes} minutes"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
                itemBuilder: (context) {
                  return [
                    ...longBreakDurations.map(
                      (duration) => PopupMenuItem(
                        value: duration,
                        child: Text("${duration.inMinutes} minutes"),
                      ),
                    )
                  ];
                },
                onSelected: (duration) {
                  setState(() {
                    _longBreak = duration;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Long break interval",
              style: labelStyle,
            ),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton<int>(
                initialValue: _longBreakInterval,
                child: ListTile(
                  title: Text("$_longBreakInterval work sessions"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
                itemBuilder: (context) {
                  return [
                    ...[2,3,4,5,6,7,8,9,10].map(
                      (interval) => PopupMenuItem(
                        value: interval,
                        child: Text("$interval work sessions"),
                      ),
                    )
                  ];
                },
                onSelected: (interval) {
                  setState(() {
                    _longBreakInterval = interval;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            processing ? Center(child: CircularProgressIndicator()) : OutlineButton(
              child: Text("Save"),
              onPressed: () async {
                setState(() {
                  processing = true;
                });
                UserRepository userRepo = Provider.of<UserRepository>(context);
                User user =  userRepo.fsUser;
                User updated = User(
                  name: user.name,
                  email: user.email,
                  id: user.id,
                  savedState: user.savedState,
                  setting: Setting(
                    longBreak: _longBreak,
                    shortBreak: _shortBreak,
                    work: _workDuration,
                    sessionsBeforeLongBreak: _longBreakInterval
                  ),
                );
                await userRepo.updateUser(updated);
                setState(() {
                  processing=false;
                });
              },
            )
          ],
        );
      }
    );
  }
}
