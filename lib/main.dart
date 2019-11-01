import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/timer/presentation/pages/timer.dart';

import 'features/auth/presentation/pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achiver',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TimerPage(task: Task(color: Colors.red,hours: 0,minutes: 0,seconds: 10,title: "hello",id: 1),),
    );
  }
}

