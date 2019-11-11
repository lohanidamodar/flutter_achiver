import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/notifiers/theme_notifier.dart';
import 'package:flutter_achiver/core/presentation/res/styles.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:provider/provider.dart';

class StatTile extends StatelessWidget {
  const StatTile({
    Key key,
    @required this.title,
    @required this.hours,
    @required this.percent,
    @required this.barWidth,
  }) : super(key: key);
  final String title;
  final String hours;
  final String percent;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BorderedContainer(
          color: Provider.of<ThemeNotifier>(context).darkTheme
              ? Theme.of(context).primaryColor
              : Colors.black54,
        ),
        AnimatedContainer(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Provider.of<ThemeNotifier>(context).darkTheme ? Colors.pink.shade300 : Colors.pink,
          ),
          width: barWidth,
          padding: const EdgeInsets.all(16.0),
          duration: Duration(milliseconds: 200),
        ),
        BorderedContainer(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(0.0),
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Text(
                hours,
                style: boldText.copyWith(color: Colors.white),
                textAlign: TextAlign.right,
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: 40.0,
                child: Text(
                  percent,
                  textAlign: TextAlign.right,
                  style: boldText.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
