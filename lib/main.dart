import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:flutter_achiver/features/auth/presentation/pages/main_screen.dart';
import 'package:flutter_achiver/features/timer/presentation/pages/timer.dart';
import 'package:provider/provider.dart';

import 'features/auth/presentation/pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => UserRepository.instance(),
        )
      ],
          child: MaterialApp(
        title: 'Achiver',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: MainScreen(),
      ),
    );
  }
}

