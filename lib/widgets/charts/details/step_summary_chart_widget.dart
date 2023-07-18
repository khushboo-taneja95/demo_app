import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';

typedef BarSelectedCallback = void Function(
    int index, ActivitySummary activity);

class StepSummaryChartWidget extends StatelessWidget {
  final List<ActivitySummary> activity;
  final double height;
  final double width;
  final String pageType;
  final BarSelectedCallback onSelected;
  final Color barColor;
  final Color labelColor;
  const StepSummaryChartWidget(
      {Key? key,
      required this.activity,
      required this.pageType,
      required this.onSelected,
      required this.barColor,
      required this.labelColor,
      this.width = double.infinity,
      this.height = 170})
      : super(key: key);

  double getBarWidth(BuildContext context, int noOfBars) {
    double screenWidth = MediaQuery.of(context).size.width - 100;
    if (width != double.infinity) {
      screenWidth = width - 60;
    }
    return screenWidth / noOfBars;
  }

  @override
  Widget build(BuildContext context) {
    final data = prepareData();
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(10),
      child: BarChart(BarChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: data['yInterval'] == 0 ? 1 : data['yInterval'],
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: labelColor,
              strokeWidth: 0.2,
            );
          },
        ),
        barGroups: List.generate(
            activity.length,
            (index) => BarChartGroupData(
                  x: index,
                  showingTooltipIndicators: [0],
                  barRods: [
                    BarChartRodData(
                      color: barColor,
                      width: getBarWidth(context, activity.length),
                      borderRadius: BorderRadius.zero,
                      toY: activity[index].ActivityValue,
                    ),
                  ],
                )),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value % (data['xInterval'] as double).toInt() == 0) {
                  return Text(
                      DateUtility.formatDateTime(
                          dateTime: activity[value.toInt()].ActivityDate,
                          outputFormat: "dd MMM"),
                      style: TextStyle(fontSize: 8, color: labelColor));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          rightTitles: AxisTitles(
            drawBehindEverything: true,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: data['yInterval'] == 0 ? 1 : data['yInterval'],
              getTitlesWidget: (value, meta) => Text(getYLabel(value),
                  style: TextStyle(fontSize: 8, color: labelColor)),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            top: BorderSide.none,
            bottom: BorderSide(color: Colors.grey, width: 0.2),
            left: BorderSide.none,
            right: BorderSide(color: Colors.grey, width: 0.2),
          ),
        ),
        barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 0,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                if (activity.length <= 7 && rod.toY != 0) {
                  return BarTooltipItem(
                    getBarValueLabel(rod.toY),
                    TextStyle(
                      color: labelColor,
                      fontSize: 7,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                } else {
                  return BarTooltipItem(
                    "",
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 0,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }
              },
            ),
            touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
              if (response != null && response.spot != null) {
                onSelected(response.spot!.touchedBarGroupIndex,
                    activity[response.spot!.touchedBarGroupIndex]);
              }
            }),
      )),
    );
  }

  String getYLabel(double value) {
    if (activity.last.ActivityType == 'Step' ||
        activity.last.ActivityType == 'Calorie' ||
        activity.last.ActivityType == 'Distance') {
      return _getShorthandNumber(value.round());
    } else if (activity.last.ActivityType == 'Sleep') {
      return DateUtility.convertMinutesToHours(value.round(),
          showInTwoDigits: false, shrink: true);
    } else {
      return value.toString();
    }
  }

  String getBarValueLabel(double value) {
    if (activity.last.ActivityType == 'Step') {
      return value.round().toStringAsFixed(0);
    } else if (activity.last.ActivityType == 'Calorie' ||
        activity.last.ActivityType == 'Distance') {
      return value.toStringAsFixed(2);
    } else if (activity.last.ActivityType == 'Sleep') {
      return DateUtility.convertMinutesToHours(value.round(),
          showInTwoDigits: false, shrink: true);
    } else {
      return value.toString();
    }
  }

  Map<String, double> prepareData() {
    //find activity with highest value
    final highestValue = activity.reduce((current, next) =>
        current.ActivityValue > next.ActivityValue ? current : next);
    return {
      "highestValue": highestValue.ActivityValue,
      "yInterval": getInterval(highestValue.ActivityValue.toInt(), parts: 7),
      "xInterval": getInterval(activity.length, parts: 7).toInt().toDouble()
    };
  }

  Widget getLabel(double value) {
    if (value.toInt() == 0 ||
        value.toInt() == activity.length - 1 ||
        value.toInt() == (activity.length - 1) / 2) {
      return Text(
          DateUtility.formatDateTime(
              dateTime: activity[value.toInt()].ActivityDate,
              outputFormat: "dd MMM"),
          style: const TextStyle(fontSize: 8, color: Colors.black));
    } else {
      return const SizedBox();
    }
  }

  double getInterval(int max, {int parts = 6}) {
    if (width == double.infinity) {
      return max / parts;
    } else {
      return max / 3;
    }
  }

  String _getShorthandNumber(int number) {
    if (number >= 1000 && number < 1000000) {
      double result = number / 1000;
      return '${result.toStringAsFixed(1)}k';
    } else if (number >= 1000000) {
      double result = number / 1000000;
      return '${result.toStringAsFixed(1)}m';
    } else {
      return number.toString();
    }
  }

  String formatNumber(double numberToFormat) {
    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol:
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(numberToFormat);
    return _formattedNumber;
  }

  List<int> divideNumber(int number, int n) {
    List<int> parts = [];
    int increment = ((number - 1) / (n - 1)).round();
    for (int i = 0; i < n; i++) {
      int value = 1 + (increment * i);
      if (i == n - 1) {
        value = number;
      }
      parts.add(value);
    }
    return parts;
  }
}
