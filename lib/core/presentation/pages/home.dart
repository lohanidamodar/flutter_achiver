import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/add_project_fab.dart';
import 'package:flutter_achiver/features/projects/presentation/widgets/projects_tab.dart';
import 'package:flutter_achiver/features/settings/presentation/widgets/settings_tab.dart';
import 'package:flutter_achiver/features/timer/presentation/notifiers/timer_state.dart';
import 'package:flutter_achiver/features/timer/presentation/widgets/timer_tab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = [
    TimerTab(),
    ProjectsTab(),
    Container(child: Text("Activity"),),
    SettingsTab(),
  ];
  int _currentPage;

  @override
  void initState() { 
    super.initState();
    _currentPage = 0;
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Achiver'),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _getSelectedTab(),
      ),
      bottomNavigationBar: Provider.of<TimerState>(context).isRunning ? null : BottomNavigationBar(
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: SizedBox(),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      floatingActionButton: _currentPage == 1 ? addProjectFab(context) : null, 
    );
  }

  Widget _getSelectedTab() {
    return _tabs[_currentPage];
  }
}