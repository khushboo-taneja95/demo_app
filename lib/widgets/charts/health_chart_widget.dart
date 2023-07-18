import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:tres_connect/core/themes/palette.dart';

class HealthChartWidget extends StatelessWidget {
  final List<HealthReading> readings;
  double xMax = 0, xMin = 0;
  double yMax = 0, yMin = 100;
  final double height;
  final bool hideBorders;
  final bool showTitles;
  final bool showSelected;
  final List<FlSpot> spots = [];
  final List<FlSpot> secondarySpots = [];
  Color lineColor = Colors.red, secondaryLineColor = Colors.grey;
  List<Color> gradientColors = [];
  String medicalCode = "";

  HealthChartWidget(this.readings,
      {super.key,
      this.height = 200,
      this.hideBorders = true,
      this.showTitles = false,
      this.showSelected = false});

  void processReadingsData() {
    secondarySpots.clear();
    spots.clear();
    int movingAverageGap = 0;
    double averageValues = 0;
    int totalNumberOfvalues = 0;
    int counter = 0;
    if (readings.length > 2 && readings.length <= 10) {
      movingAverageGap = 3;
    } else if (readings.length > 10 && readings.length <= 30) {
      movingAverageGap = 3;
    } else {
      movingAverageGap = 4;
    }

    medicalCode = readings.last.MedicalCode;

    double index = 0;
    xMin = index;
    secondarySpots.add(FlSpot(0, readings.first.ReadingMax));
    for (var reading in readings) {
      double hr = reading.ReadingMax;

      //Moving Avg Logic
      averageValues = averageValues + hr;
      totalNumberOfvalues = totalNumberOfvalues + 1;
      if (totalNumberOfvalues == movingAverageGap) {
        averageValues = averageValues / totalNumberOfvalues;
        totalNumberOfvalues = 0;
        secondarySpots.add(FlSpot(index, averageValues));
        averageValues = 0;
      }

      spots.add(FlSpot(index, hr));
      yMax = max(yMax, hr);
      yMin = min(yMin, hr);
      index++;
    }
    //add first and last values to average graph list
    secondarySpots.add(FlSpot(readings.length - 1, readings.first.ReadingMax));

    yMin = yMin - 5;
    xMax = index - 1;
    if (readings.last.MedicalCode == "HR") {
      lineColor = Palette.hrLineColor;
      secondaryLineColor = Colors.white;
      gradientColors = [lineColor, Colors.white];
    } else if (readings.last.MedicalCode == "BP") {
      lineColor = Palette.highBPLineColor;
      secondaryLineColor = Palette.lowBPLineColor;
      gradientColors = [lineColor, Colors.white];
    } else if (readings.last.MedicalCode == "BT") {
      lineColor = Palette.btLineColor;
      gradientColors = [lineColor, Colors.white];
    } else if (readings.last.MedicalCode == "OS") {
      lineColor = Palette.osLineColor;
      gradientColors = [lineColor, Colors.white];
    }
    debugPrint("xMin: $xMin, xMax: $xMax, yMin: $yMin, yMax: $yMax");
  }

  @override
  Widget build(BuildContext context) {
    processReadingsData();
    return Container(
        height: height,
        margin: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 0),
        child: LineChart(LineChartData(
          gridData: FlGridData(
            show: false,
            drawVerticalLine: true,
            horizontalInterval: 10,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
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
                  showTitles: showTitles,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: showTitles,
                interval: 1,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              top: BorderSide.none,
              bottom: hideBorders
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xff37434d)),
              left: BorderSide.none,
              right: hideBorders
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xff37434d)),
            ),
          ),
          lineTouchData: LineTouchData(
            enabled: showSelected,
          ),
          minX: xMin,
          maxX: xMax,
          minY: yMin,
          maxY: yMax,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: lineColor,
              isCurved: true,
              barWidth: 1.5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.6))
                      .toList(),
                ),
              ),
            ),
            // LineChartBarData(
            //   spots: secondarySpots,
            //     isCurved: true,
            //     color: secondaryLineColor,
            //     barWidth: 1,
            //     isStrokeCapRound: true,
            //     dotData: FlDotData(
            //       show: false,
            //     ),
            // ),
          ],
        )));
  }

  //New Chart Code
  Widget newChartWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: LineChart(
        LineChartData(
          minX:
              readings.first.TimeStamp.millisecondsSinceEpoch.toDouble() / 1000,
          maxX:
              readings.last.TimeStamp.millisecondsSinceEpoch.toDouble() / 1000,
          minY: readings
                  .reduce((a, b) => a.ReadingMax < b.ReadingMax ? a : b)
                  .ReadingMax -
              10,
          maxY: readings
                  .reduce((a, b) => a.ReadingMax > b.ReadingMax ? a : b)
                  .ReadingMax +
              10,
          gridData: FlGridData(
            show: false,
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              top: BorderSide.none,
              bottom: hideBorders
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xff37434d)),
              left: BorderSide.none,
              right: hideBorders
                  ? BorderSide.none
                  : const BorderSide(color: Color(0xff37434d)),
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: showTitles,
                interval: 1,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (hideBorders) {
                    return const SizedBox();
                  }
                  final interval = (readings
                                  .last.TimeStamp.millisecondsSinceEpoch /
                              1000 -
                          readings.first.TimeStamp.millisecondsSinceEpoch /
                              1000) ~/
                      4; // Calculate the interval based on the range of values
                  final index = ((value.toInt() -
                              readings.first.TimeStamp.millisecondsSinceEpoch /
                                  1000) /
                          interval)
                      .round();

                  final timestamp =
                      readings.first.TimeStamp.millisecondsSinceEpoch / 1000 +
                          index * interval;
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      timestamp.toInt() * 1000);
                  // if (lastIndex == index) {
                  //   return Text('');
                  // }
                  // lastIndex = index;
                  return Text(
                    '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: lineColor,
              isCurved: true,
              barWidth: 1.5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.6))
                      .toList(),
                ),
              ),
              spots: List.generate(
                readings.length,
                (index) {
                  return FlSpot(readings[index].ReadingMax.toDouble(),
                      readings[index].ReadingMax.toDouble());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int count = 3;
    int interval = readings.length ~/ count;
    int listLength = readings.length - 1;
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 8,
    );
    Widget text = Container();
    if (value.toInt() == 0) {
      text = Text(DateFormat("HH:mm a").format(readings.elementAt(0).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength / 2) {
      text = Text(
          DateFormat("HH:mm a").format(
              readings.elementAt((listLength / 2 - 1).toInt()).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength ~/ 4) {
      text = Text(
          DateFormat("HH:mm a").format(
              readings.elementAt((listLength / 4 - 1).toInt()).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength ~/ 1.33) {
      text = Text(
          DateFormat("HH:mm a")
              .format(readings.elementAt(listLength ~/ 1.33).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength) {
      text = Text(
          DateFormat("HH:mm a")
              .format(readings.elementAt(listLength - 1).TimeStamp),
          style: style);
    } else {
      text = Container();
    }
    if (value.toInt() == readings.length / 2) {}

    // for (int i = 0; i <= count; i++) {
    //   if (value.toInt() == interval * i) {
    //     text = Text(
    //         DateFormat("HH:mm a").format(readings.elementAt(0).TimeStamp),
    //         style: style);
    //   } else {
    //     text = Container();
    //   }
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    int divideIn = 5;
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 8,
    );
    String text = "";
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 60:
        text = '60';
        break;
      case 90:
        text = '90';
        break;
      case 120:
        text = '120';
        break;
      case 150:
        text = '150';
        break;
      default:
        return Container();
    }

    return Text(" $text", style: style, textAlign: TextAlign.left);
  }
}
