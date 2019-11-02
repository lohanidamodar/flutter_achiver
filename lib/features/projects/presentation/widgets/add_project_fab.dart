import 'package:flutter/material.dart';

Widget addProjectFab(BuildContext context) => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, 'add_project'),
      );