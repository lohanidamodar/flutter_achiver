import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/pages/home.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:flutter_achiver/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:provider/provider.dart';
import './splash.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserRepository user, _) {
        switch (user.status) {
          case Status.Uninitialized:
            return Splash();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return WelcomePage();
          case Status.Authenticated:
            return HomePage();
        }
      },
    );
  }
}