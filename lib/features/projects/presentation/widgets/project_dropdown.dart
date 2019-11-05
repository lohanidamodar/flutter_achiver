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
    return InkWell(
      onTap: widget.disabled ? null : _showSelectProject,
      child: Container(
        color: widget.disabled ? Theme.of(context).disabledColor : Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.label ?? "selected project",
                    style: Theme.of(context).textTheme.button,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    _selectedProject?.title ?? "no project selected",
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: secondaryText,
            ),
          ],
        ),
      ),
    );
  }

  _showSelectProject() async {
    Project project = await showDialog<Project>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Select Project"),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
                child: ProjectSelectList(
              onTap: (project) => Navigator.pop(context, project),
              projects: Provider.of<List<Project>>(context),
              selectedProject: widget.initialProject,
            )),
          ],
        ),
      ),
    );
    if (project != null) {
      setState(() {
        _selectedProject = project;
      });
      widget.onSelectProject(project);
    }
  }
}
