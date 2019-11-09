import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/projects/data/model/project_model.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/project_dropdown.dart';
import 'package:flutter_achiver/features/stat/data/model/log_model.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';

class AddWorkLogPage extends StatefulWidget {
  @override
  _AddWorkLogPageState createState() => _AddWorkLogPageState();
}

class _AddWorkLogPageState extends State<AddWorkLogPage> {
  Project _project;
  DateTime _date;
  TimeOfDay _time;
  bool _processing;

  @override
  void initState() { 
    super.initState();
    _date = DateTime.now();
    _time = TimeOfDay.now();
    _processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new log entry'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Project"),
            const SizedBox(height: 5.0),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: ProjectDropdown(
                label: "Project",
                initialProject: _project,
                onSelectProject: (project) {
                  setState(() {
                    _project = project;
                  });
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Text("Completed date"),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_date.toString().replaceRange(10, _date.toString().length, "")),
                ),
                onTap: _datePicker,
              ),
            ),
            const SizedBox(height: 10.0),
            Text("Completed time"),
            BorderedContainer(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_time.format(context)),
                ),
                onTap: _timePicker,
              ),
            ),
            const SizedBox(height: 10.0),
            _processing
                ? Center(child: CircularProgressIndicator())
                : MaterialButton(
                  elevation: 0,
                  padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_project != null) {
                      setState(() {
                        _processing = true;
                      });                    
                      await logDBS.createItem(WorkLog(
                        date: DateTime(_date.year,_date.month, _date.day, _time.hour, _time.minute),
                        duration: _project.workDuration,
                        project: _project,
                      ));
                      Navigator.pop(context);
                      setState(() {
                        _processing = false;
                      });
                    }
                  },
                  child: Text("Save"),
                ),
          ],
        ),
      ),
    );
  }

  _datePicker() async {
    DateTime picked = await showDatePicker(
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      context: context,
      initialDate: _date,
    );
    if(picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  _timePicker() async {
    TimeOfDay picked = await showTimePicker(
      initialTime: _time,
      context: context,
    );
    if(picked != null) {
      setState(() {
        _time = picked;
      });
    }
  }

}
