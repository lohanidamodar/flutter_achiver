import 'package:flutter/material.dart';

Widget addWorkLogFab(BuildContext context) => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, 'add_work_log'),
      );