import 'package:flutter/material.dart';
import 'package:flutter_achiver/features/stat/data/service/firestore_log_service.dart';
import 'package:flutter_achiver/features/stat/presentation/widgets/stats_from_logs.dart';
import 'package:flutter_achiver/features/stat/res/constants.dart';
import 'date_chooser_wrapper.dart';

class StatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,50.0),
      child: DateChooserWrapper(
        builder: (context,DateTime from, DateTime to, ChartTimeType type) {
          return Column(
            children: <Widget>[
              FutureBuilder(
                future: logDBS.getListFromTo('date', from, to),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError) {
                    print(snapshot.error);
                    return Container(child: Text("Error"),);
                  } 
                  if(!snapshot.hasData) return CircularProgressIndicator();
                  return StatsFromLogs(logs: snapshot.data, chartTimeType: type,);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}