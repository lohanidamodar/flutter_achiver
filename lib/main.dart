import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/data/res/constants.dart';
import 'package:flutter_achiver/core/data/service/db_service.dart';
import 'package:flutter_achiver/core/presentation/notifiers/theme_notifier.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:flutter_achiver/features/auth/presentation/pages/main_screen.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/data/services/firestore_project_service.dart';
import 'package:flutter_achiver/features/projects/presentation/pages/add_project.dart';
import 'package:flutter_achiver/features/projects/presentation/pages/projects.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(ProvidedApp());

class ProvidedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (_) => UserRepository.instance(),
        ),
        ChangeNotifierProxyProvider<UserRepository, TimerState>(
          builder: (context, user, timerState) => TimerState(user: user.fsUser),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeNotifier>(context).currentTheme;
    return Consumer<UserRepository>(builder: (context, user, child) {
      if(user.user!=null) {
        initWorkLogDBS(user.user.uid);
        initProjectDBS(user.user.uid);
      }
      return MultiProvider(
        providers: [
          StreamProvider.value(
            value: projectDBS?.streamList(),
          ),
        ],
        child: MaterialApp(
          title: 'Achiver',
          theme: theme,
          home: MainScreen(),
          routes: {
            "projects": (_) => ProjectsPage(),
            "add_project": (_) => AddProjectPage(),
          },
        ),
      );
    });
  }
}
