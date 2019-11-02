import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';

class TimerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          BorderedContainer(
            child: Column(
              children: <Widget>[
                Text("Motivation Text"),
                OutlineButton(
                  child: Text("Start Work Session"),
                  onPressed: (){},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          BorderedContainer(
            child: Column(
              children: <Widget>[
                Text("Current Project"),
                Text("work sessions completed today"),
                Text("Daily average (Last 7 Days)"),
              ],
            ),
          )
        ],
      ),
    );
  }
}