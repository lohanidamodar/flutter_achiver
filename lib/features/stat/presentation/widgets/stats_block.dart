import 'package:flutter/material.dart';

class StatsBlock extends StatelessWidget {
  const StatsBlock({
    Key key,
    @required this.child,
    this.width,
  }) : super(key: key);

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}