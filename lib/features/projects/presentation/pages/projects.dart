import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/data/services/firestore_project_service.dart';
import 'package:flutter_achiver/features/projects/presentation/pages/add_project.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: Consumer<List<Project>>(
        builder: (context, projects, child) {
          if(projects == null) return Center(child: CircularProgressIndicator());
          if(projects.isEmpty) return Container(child: Text("No projects found"),);
          return ListView.separated(
            itemCount: projects.length,
            itemBuilder: (context,index) {
              Project project = projects[index];
              return ListTile(
                title: Text(project.title),
                subtitle: Text(statusToString(project.status)),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => projectDBS.removeItem(project.id),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => AddProjectPage(project: project,),
                )),
              );
            },
            separatorBuilder: (context,index) => const SizedBox(height: 10.0),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, 'add_project'),
      ),
    );
  }
}
