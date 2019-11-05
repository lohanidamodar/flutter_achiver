import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/core/presentation/widgets/confirm_dialog.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/data/services/firestore_project_service.dart';
import 'package:flutter_achiver/features/projects/presentation/pages/add_project.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/project_list_item.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<List<Project>>(
      builder: (context, projects, child) {
        if (projects == null) return Center(child: CircularProgressIndicator());
        if (projects.isEmpty)
          return Container(
            child: Text("No projects found"),
          );
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            Project project = projects[index];
            return BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: ProjectListItem(
                project: project,
                onDelete: () => _onDelete(context, project),
                onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddProjectPage(
                        project: project,
                      ),
                    )),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        );
      },
    );
  }

  void _onDelete(BuildContext context, Project project) async {
    bool delete = await showDialog<bool>(
        context: context,
        builder: (_) => ConfirmDialog(
              title: "Are you sure?",
              content: "Once deleted it cannot be undone",
            ));
    if (delete) {
      projectDBS.removeItem(project.id);
    }
  }
}
