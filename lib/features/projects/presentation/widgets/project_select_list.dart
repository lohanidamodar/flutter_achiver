import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';

import 'project_list_item.dart';

class ProjectSelectList extends StatefulWidget {
  final List<Project> projects;
  final Project selectedProject;
  final Function(Project) onTap;

  const ProjectSelectList({Key key, @required this.projects, this.selectedProject,@required this.onTap}) : super(key: key);
  @override
  _ProjectSelectListState createState() => _ProjectSelectListState();
}

class _ProjectSelectListState extends State<ProjectSelectList> {
  Project _selectedProject;

  @override
  void initState() { 
    super.initState();
    _selectedProject = widget.selectedProject;
  }

  @override
  Widget build(BuildContext context) {
    List<Project> projects = widget.projects.where((project) => project.status == ProjectStatus.ONGOING).toList();
    return ListView.separated(
          itemCount: projects.length,
          itemBuilder: (context,index) {
            Project project = projects[index];
            return ProjectListItem(
              project: project,
              isSelected: project.id == _selectedProject?.id,
              onTap: (){
                setState(() {
                  _selectedProject = project;
                  widget.onTap(project);
                });
              },
            );
          },
          separatorBuilder: (context,index) => const SizedBox(height: 10.0),
        );
  }
}