import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';

class BorderedContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;

  const BorderedContainer({
    Key key,
    this.title,
    this.child,
    this.height,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(4.0),
        color: color != null ? color : Colors.white,
      ),
      child: title == null
          ? child
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                ),
                if (child != null) ...[const SizedBox(height: 10.0), child]
              ],
            ),
    );
  }
}
