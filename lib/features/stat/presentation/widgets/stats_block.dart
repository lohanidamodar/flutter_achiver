import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/notifiers/theme_notifier.dart';
import 'package:provider/provider.dart';

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
        color: Provider.of<ThemeNotifier>(context).darkTheme ? Theme.of(context).primaryColor : Colors.black87,
      ),
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}