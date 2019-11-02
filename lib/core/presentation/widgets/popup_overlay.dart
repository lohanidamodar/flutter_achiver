import 'package:flutter/material.dart';

class PopUpOverlay extends StatelessWidget {
  final Widget body;
  final bool isVisible;
  final Widget content;
  final bool showSpinner;
  final String spinnerText;
  final bool forceContentVisible;
  final GestureTapCallback onBackgroundTap;

  PopUpOverlay({
    this.content,
    this.showSpinner,
    this.spinnerText,
    @required this.body,
    this.onBackgroundTap,
    @required this.isVisible,
    this.forceContentVisible = false,
  });

  Widget _overlayView({Widget withSpinner}) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: withSpinner != null
          ? Container(child: withSpinner, color: Colors.black.withOpacity(0.4))
          : GestureDetector(
              child: Container(color: Colors.black.withOpacity(0.4)),
              onTap: onBackgroundTap,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        if (isVisible == true) _overlayView(),
        if (forceContentVisible == true || isVisible == true)
          content ?? SizedBox(),
        if (showSpinner == true)
          _overlayView()
      ],
    );
  }
}
