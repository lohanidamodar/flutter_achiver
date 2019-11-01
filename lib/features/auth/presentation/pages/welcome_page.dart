import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/auth/presentation/notifiers/user_repository.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            RaisedButton(
              child: Text("Continue with Google"),
              onPressed: () async {
                if (!await Provider.of<UserRepository>(context)
                    .signInWithGoogle())
                  _key.currentState.showSnackBar(SnackBar(
                    content: Text("Something is wrong"),
                  ));
              },
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              child: Text("Continue without login"),
              onPressed: () {},
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
