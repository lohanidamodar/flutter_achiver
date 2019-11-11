import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:flutter_achiver/core/presentation/widgets/bordered_container.dart';
import 'package:flutter_achiver/features/stat/res/constants.dart';
import 'package:flutter_achiver/core/presentation/res/functions.dart';
import 'package:intl/intl.dart';
import 'package:date_utils/date_utils.dart' as dateUtils;

class DateChooserWrapper extends StatefulWidget {
  final Widget Function(
      BuildContext, DateTime, DateTime, ChartTimeType chartTimeType) builder;

  const DateChooserWrapper({Key key, this.builder}) : super(key: key);
  @override
  _DateChooserWrapperState createState() => _DateChooserWrapperState();
}

class _DateChooserWrapperState extends State<DateChooserWrapper> {
  DateTime from;
  DateTime to;
  DateTime date;
  ChartTimeType chartTimeType;

  @override
  void initState() {
    super.initState();
    date = today;
    chartTimeType = ChartTimeType.WEEKLY;
    initDates();
  }

  initDates() {
    if (isWeekly(chartTimeType)) {
      from = beginingOfDay(dateUtils.Utils.firstDayOfWeek(date));
      to = endOfDay(DateTime(from.year, from.month, from.day + 6));
    } else if (isMonthly(chartTimeType)) {
      from = beginingOfDay(dateUtils.Utils.firstDayOfMonth(date));
      to = endOfDay(dateUtils.Utils.lastDayOfMonth(date));
    } else if (isYearly(chartTimeType)) {
      from = beginingOfDay(firstDayOfYear(date));
      to = endOfDay(lastDayOfYear(date));
    } else if (isDaily(chartTimeType)) {
      from = beginingOfDay(date);
      to = endOfDay(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildButtonsRow(context),
              _buildHeaderButtons(),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        widget.builder(context, from, to, chartTimeType),
      ],
    );
  }

  Row _buildHeaderButtons() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            print("previous week");
            setState(() {
              if (isWeekly(chartTimeType)) {
                date = dateUtils.Utils.previousWeek(date);
              } else if (isMonthly(chartTimeType)) {
                date = dateUtils.Utils.previousMonth(date);
              } else if (isYearly(chartTimeType)) {
                date = prevYear(date);
              } else if (isDaily(chartTimeType)) {
                date = prevDay(date);
              }
              initDates();
            });
          },
        ),
        Expanded(
          child: isWeekly(chartTimeType)
              ? Text(
                  "${DateFormat.MMMd().format(from)} - ${DateFormat.yMMMd().format(to)}",
                  textAlign: TextAlign.center,
                )
              : isDaily(chartTimeType)
                  ? Text(
                      "${DateFormat.yMMMMEEEEd().format(from)}",
                      textAlign: TextAlign.center,
                    )
                  : isYearly(chartTimeType)
                      ? Text(
                          DateFormat.y().format(from),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "${DateFormat.yMMM().format(from)}",
                          textAlign: TextAlign.center,
                        ),
        ),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: dateUtils.Utils.isSameWeek(date, today)
              ? null
              : () {
                  setState(() {
                    if (isWeekly(chartTimeType))
                      date = dateUtils.Utils.nextWeek(date);
                    else if (isMonthly(chartTimeType))
                      date = dateUtils.Utils.nextMonth(date);
                    else if (isYearly(chartTimeType))
                      date = nextYear(date);
                    else if (isDaily(chartTimeType)) date = nextDay(date);
                    initDates();
                  });
                },
        ),
      ],
    );
  }

  Row _buildButtonsRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0))),
            color: isDaily(chartTimeType)
                ? Theme.of(context).primaryColor
                : bgColor,
            textColor: isDaily(chartTimeType) ? Colors.white : Colors.black87,
            elevation: 0,
            child: Text("D"),
            onPressed: () {
              setState(() {
                chartTimeType = ChartTimeType.DAILY;
                initDates();
              });
            },
          ),
        ),
        VerticalDivider(
          width: 1.0,
        ),
        Expanded(
          child: MaterialButton(
            color: isWeekly(chartTimeType)
                ? Theme.of(context).primaryColor
                : bgColor,
            textColor: isWeekly(chartTimeType) ? Colors.white : Colors.black87,
            elevation: 0,
            child: Text("W"),
            onPressed: () {
              setState(() {
                chartTimeType = ChartTimeType.WEEKLY;
                initDates();
              });
            },
          ),
        ),
        VerticalDivider(
          width: 1.0,
        ),
        Expanded(
          child: MaterialButton(
            shape: ContinuousRectangleBorder(),
            color: isMonthly(chartTimeType)
                ? Theme.of(context).primaryColor
                : bgColor,
            elevation: 0,
            child: Text("M"),
            textColor: isMonthly(chartTimeType) ? Colors.white : Colors.black87,
            onPressed: () {
              setState(() {
                chartTimeType = ChartTimeType.MONTHLY;
                initDates();
              });
            },
          ),
        ),
        VerticalDivider(
          width: 1.0,
        ),
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            color: isYearly(chartTimeType)
                ? Theme.of(context).primaryColor
                : bgColor,
            elevation: 0,
            textColor: isYearly(chartTimeType) ? Colors.white : Colors.black87,
            child: Text("Y"),
            onPressed: () {
              setState(() {
                chartTimeType = ChartTimeType.YEARLY;
                initDates();
              });
            },
          ),
        ),
      ],
    );
  }
}
