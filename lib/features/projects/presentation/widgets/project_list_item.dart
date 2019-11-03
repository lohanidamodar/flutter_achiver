import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';

class ProjectListItem extends StatelessWidget {
  final Project project;
  final Function onTap;
  final Function onDelete;
  final Function onEdit;
  final bool isSelected;

  const ProjectListItem({Key key, @required this.project,this.onTap, this.onDelete, this.onEdit, this.isSelected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Center(child: Image.asset(statusToIcon(project.status),fit: BoxFit.contain,)),
      ),
      title: Text(project.title),
      subtitle: Text("${project.workDuration.inMinutes} minutes"),
      onTap: onTap,
      onLongPress: onEdit,
      selected: isSelected,
      trailing: onDelete != null ? IconButton(icon: Icon(Icons.delete), onPressed: onDelete,) : null,
    );
  }
}