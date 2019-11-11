import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/assets.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink,Colors.indigo],
          ),
          image: DecorationImage(
            image: AssetImage(welcomeBg),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.dstATop)
          )
        ),
        child: CircularProgressIndicator(),
      ),
    );
  }
}