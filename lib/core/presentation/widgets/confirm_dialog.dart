import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String positiveButtonLabel;
  final String negativeButtonLabel;
  final TextStyle titleStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  ConfirmDialog(
      {Key key,
      this.title,
      this.content,
      this.positiveButtonLabel = "Delete",
      this.negativeButtonLabel = "Cancel"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).dialogBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  content,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 0,
                      color: Colors.grey,
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(negativeButtonLabel),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    SizedBox(width: 10.0),
                    RaisedButton(
                      elevation: 0,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(positiveButtonLabel),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
