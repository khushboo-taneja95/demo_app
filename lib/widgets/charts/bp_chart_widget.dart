import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:tres_connect/core/themes/palette.dart';

class BPChartWidget extends StatelessWidget {
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

  BPChartWidget(this.readings,
      {super.key, this.height = 200,
        this.hideBorders = true,
      this.showTitles = false,
      this.showSelected = false});

  void processReadingsData() {
    secondarySpots.clear();
    spots.clear();

    double index = 0;
    xMin = index;

    for (var reading in readings) {
      double maxVal = reading.ReadingMax;
      double minVal = reading.ReadingMin;
      spots.add(FlSpot(index, reading.ReadingMax));
      secondarySpots.add(FlSpot(index, reading.ReadingMin));
      yMax = max(yMax, maxVal);
      yMin = min(yMin, minVal);
      index++;
    }

    yMin = yMin - 5;
    xMax = index - 1;
    lineColor = Palette.highBPLineColor;
    secondaryLineColor = Palette.lowBPLineColor;
    gradientColors = [lineColor, Colors.white];
    print("xMin: $xMin, xMax: $xMax, yMin: $yMin, yMax: $yMax");
  }

  @override
  Widget build(BuildContext context) {
    processReadingsData();
    return Container(
      height: height,
        margin:
            const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 0),
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
                : const BorderSide(color: Color(0xff37434d)),),
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
              isCurved: false,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 1.5,
                    color: lineColor,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  );
                },
              ),
            ),
            LineChartBarData(
              spots: secondarySpots,
              color: secondaryLineColor,
              isCurved: false,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 1.5,
                    color: secondaryLineColor,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  );
                },
              ),
            ),
          ],
        )));
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
    }
    else if (value.toInt() == listLength / 2) {
      text = Text(
          DateFormat("HH:mm a").format(
              readings.elementAt((listLength / 2 - 1).toInt()).TimeStamp),
          style: style);
    }
    else if (value.toInt() == listLength ~/ 4) {
      text = Text(
          DateFormat("HH:mm a").format(
              readings.elementAt((listLength / 4 - 1).toInt()).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength ~/ 1.33) {
      text = Text(
          DateFormat("HH:mm a").format(
              readings.elementAt(listLength ~/ 1.33).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength) {
      text = Text(
          DateFormat("HH:mm a")
              .format(readings.elementAt(listLength - 1).TimeStamp),
          style: style);
    } else {
      text = Container();
    }
    if(value.toInt() == readings.length / 2){

    }

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
    String text;

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
