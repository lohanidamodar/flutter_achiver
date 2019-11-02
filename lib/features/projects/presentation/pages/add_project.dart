import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/assets.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:flutter_achiver/core/presentation/res/styles.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/data/services/firestore_project_service.dart';

class AddProjectPage extends StatefulWidget {
  final Project project;

  const AddProjectPage({Key key, this.project}) : super(key: key);

  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  ProjectStatus _status;
  Duration _workDuration;
  final List<ProjectStatus> _statusList = [
    ProjectStatus.ONGOING,
    ProjectStatus.SUSPENDED,
    ProjectStatus.COMPLETED,
  ];
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.project != null ? widget.project.title : "");
    _workDuration = widget.project != null
        ? widget.project.workDuration
        : Duration(minutes: 25);
    processing = false;
    _status =
        widget.project != null ? widget.project.status : ProjectStatus.ONGOING;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project != null ? "Edit project" : "Add project"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text("Project title",style: labelStyle,),
            const SizedBox(height: 5.0),
            TextFormField(
              controller: _title,
              validator: (value) =>
                  (value.isEmpty) ? "Please Enter title" : null,
              style: style,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16.0),
                hintText: "please enter title",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text("Work session duration",style: labelStyle,),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton<Duration>(
                initialValue: _workDuration,
                child: ListTile(
                  title: Text("${_workDuration.inMinutes} minutes"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
                itemBuilder: (context) {
                  return [
                    ...durations.map(
                      (duration) => PopupMenuItem(
                        value: duration,
                        child: Text("${duration.inMinutes} minutes"),
                      ),
                    )
                  ];
                },
                onSelected: (duration) {
                  setState(() {
                    _workDuration = duration;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text("Project status",style: labelStyle,),
            const SizedBox(height: 5.0),
            ToggleButtons(
              renderBorder: false,
              selectedColor: Theme.of(context).primaryColor,
              color: Colors.white,
              
              fillColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4.0),
              onPressed: (index) {
                setState(() {
                  _status = _statusList[index];
                });
              },
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    projectOngoingIcon,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    projectSuspendedIcon,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    projectCompleteIcon,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              isSelected: [
                _status == ProjectStatus.ONGOING,
                _status == ProjectStatus.SUSPENDED,
                _status == ProjectStatus.COMPLETED,
              ],
            ),
            SizedBox(height: 20.0),
            processing
                ? Center(child: CircularProgressIndicator())
                : MaterialButton(
                  elevation: 0,
                  padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        processing = true;
                      });
                      if (widget.project != null) {
                        await projectDBS.updateItem(Project(
                            id: widget.project.id,
                            title: _title.text,
                            status: _status,
                            workDuration: _workDuration));
                      } else {
                        await projectDBS.createItem(Project(
                            title: _title.text,
                            status: _status,
                            workDuration: _workDuration));
                      }
                      Navigator.pop(context);
                      setState(() {
                        processing = false;
                      });
                    }
                  },
                  child: Text(
                    "Save",
                    style: style,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }
}
