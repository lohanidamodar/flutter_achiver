import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/project_select_list.dart';
import 'package:provider/provider.dart';

class ProjectDropdown extends StatefulWidget {
  final String label;
  final Project initialProject;
  final Function(Project) onSelectProject;
  final bool disabled;
  const ProjectDropdown({
    Key key,
    this.label,
    this.initialProject,
    this.disabled = false,
    @required this.onSelectProject,
  }) : super(key: key);

  @override
  _ProjectDropdownState createState() => _ProjectDropdownState();
}

class _ProjectDropdownState extends State<ProjectDropdown> {
  Project _selectedProject;
  @override
  void initState() {
    super.initState();
    _selectedProject = widget.initialProject;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Project>(
      initialValue: _selectedProject,
      child: ListTile(
        title: Text(_selectedProject?.title ?? "No project selected"),
        trailing: Icon(Icons.keyboard_arrow_down),
      ),
      itemBuilder: (context) => [
        ...Provider.of<List<Project>>(context).map((project)=> PopupMenuItem(
          child: Text(project.title),
          value: project,
        )),
      ],
      onSelected: widget.disabled ? null : (project) {
        setState(() {
          _selectedProject = project;
        });
        widget.onSelectProject(project);
      },
    );
  }
}
