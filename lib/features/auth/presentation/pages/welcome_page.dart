import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/assets.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(welcomeBg),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              color: Colors.black87,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Achiver - Pomodoro timer and tracker",style: Theme.of(context).textTheme.display1, textAlign: TextAlign.center,),
                const SizedBox(height: 10.0),
                Text("Get more done with pomodoro technique.",style: Theme.of(context).textTheme.title, textAlign: TextAlign.center,),
                const SizedBox(height: 10.0),
                Text("Track your time effectively.",style: Theme.of(context).textTheme.title, textAlign: TextAlign.center,),
                const SizedBox(height: 10.0),
                Text("Get effective analytics.",style: Theme.of(context).textTheme.title, textAlign: TextAlign.center,)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
                      child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                  child: Text("Continue with Google"),
                  onPressed: () async {
                    if (!await Provider.of<UserRepository>(context)
                        .signInWithGoogle())
                      _key.currentState.showSnackBar(SnackBar(
                        content: Text("Something is wrong"),
                      ));
                  },
                ),
            ),
          ),
        ],
      ),
    );
  }
}
