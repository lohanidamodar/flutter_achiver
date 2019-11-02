import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/project_list.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ProjectList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, 'add_project'),
      ),
    );
  }
}