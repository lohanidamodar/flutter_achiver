import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(child: SizedBox(),),
            RaisedButton(
              child: Text("Continue with Google"),
              onPressed: (){},
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              child: Text("Continue without login"),
              onPressed: (){},
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}