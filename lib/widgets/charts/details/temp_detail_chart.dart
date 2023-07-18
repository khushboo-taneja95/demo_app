import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/global_configuration.dart';

class TempDetailChartWidget extends StatelessWidget {
  String unit = "";
  final List<HealthReading> readings;
  double xMax = 0, xMin = 0;
  double yMax = 0, yMin = 100;
  final width = double.infinity;
  final String pageType;
  final double height;
  final bool hideBorders;
  final bool showTitles;
  final bool showSelected;
  final bool isFarenheit;
  final List<FlSpot> spots = [];
  final List<FlSpot> secondarySpots = [];
  Color lineColor = Colors.red, secondaryLineColor = Colors.grey;
  List<Color> gradientColors = [];
  final Function(HealthReading dateTime, String value)? onSelected;
  final DateTime startDate;
  final DateTime endDate;
  String medicalCode = "";

  double normalRangeMin = 0, normalRangeMax = 0;
  Color normalRangeMinColor = Colors.transparent,
      normalRangeMaxColor = Colors.transparent;

  TempDetailChartWidget(this.readings,
      {super.key,
      this.height = 200,
      required this.onSelected,
      required this.pageType,
      required this.startDate,
      required this.endDate,
      this.isFarenheit = false,
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
    medicalCode = readings.first.MedicalCode;
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

    secondarySpots.add(FlSpot(readings.length - 1, readings.first.ReadingMax));

    yMin = yMin - 5;
    if (yMin < 0) yMin = 0;
    xMax = index - 1;
    yMax = yMax + 10;
    if (readings.last.MedicalCode == "HR") {
      normalRangeMin = 60;
      normalRangeMax = 100;
      lineColor = Palette.hrLineColor;
      secondaryLineColor = Colors.white;
      gradientColors = [lineColor, Colors.white];
      normalRangeMaxColor = const Color(0xff205668);
      normalRangeMinColor = const Color(0xff264B63);
      yMax = max(120, yMax);
    } else if (readings.last.MedicalCode == "BP") {
      lineColor = Palette.highBPLineColor;
      secondaryLineColor = Palette.lowBPLineColor;
      gradientColors = [lineColor, Colors.white];
    } else if (readings.last.MedicalCode == "BT") {
      normalRangeMin = 36.1;
      normalRangeMax = 37.2;
      lineColor = Palette.btLineColor;
      gradientColors = [lineColor, Colors.white];
      secondaryLineColor = Colors.white;
    } else if (readings.last.MedicalCode == "OS") {
      normalRangeMin = 90;
      normalRangeMax = 100;
      yMax = 100;
      normalRangeMinColor = const Color(0xff264B63);
      normalRangeMaxColor = const Color(0xff374d65);
      lineColor = Palette.osLineColor;
      gradientColors = [const Color(0xff3caaea), const Color(0xff3caaea)];
      secondaryLineColor = Colors.white;
    }
    yMin = min(normalRangeMin, yMin);
    yMax = max(normalRangeMax, yMax);
    // if (pageType == "WEEK" || pageType == "MONTH") {
    //   xMin = startDate.millisecondsSinceEpoch / 1000;
    //   xMax = endDate.millisecondsSinceEpoch / 1000;
    // }
    print(
        "xMin: $xMin, xMax: $xMax, yMin: $yMin, yMax: $yMax, normalRangeMin: $normalRangeMin, normalRangeMax: $normalRangeMax");
  }

  @override
  Widget build(BuildContext context) {
    processReadingsData();
    final data = prepareData();
    print(data);
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
                interval: 8,
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
            touchCallback: (event, response) {
              if (response != null &&
                  response.lineBarSpots != null &&
                  response.lineBarSpots!.isNotEmpty) {
                onSelected!(readings[response.lineBarSpots!.first.x.toInt()],
                    response.lineBarSpots!.first.y.toStringAsFixed(0));
              }
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                  );
                  return LineTooltipItem(
                      getTemperatureValue(
                              double.parse(touchedSpot.y.toStringAsFixed(1)))
                          .toString(),
                      textStyle);
                }).toList();
              },
            ),
          ),
          minX: xMin,
          maxX: xMax,
          minY: yMin,
          maxY: yMax,
          lineBarsData: [
            LineChartBarData(
              //max range line for graph
              spots: [
                FlSpot(0, normalRangeMax),
                FlSpot(xMax, normalRangeMax),
              ],
              isCurved: true,
              color: normalRangeMaxColor,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                color: normalRangeMaxColor,
              ),
            ),
            LineChartBarData(
              //min range line for graph
              spots: [
                FlSpot(0, normalRangeMin),
                FlSpot(xMax, normalRangeMin),
              ],
              isCurved: true,
              color: normalRangeMinColor,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                color: normalRangeMinColor,
              ),
            ),
            LineChartBarData(
              //normal line for graph
              preventCurveOverShooting: false,
              spots: spots,
              color: lineColor,
              isCurved: true,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xff42768B),
              ),
            ),
            LineChartBarData(
              //average line for graph,
              curveSmoothness: 0.35,
              preventCurveOverShooting: true,
              spots: secondarySpots,
              isCurved: true,
              color: secondaryLineColor,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
        )));
  }

  Widget getLabel(double value) {
    if (value.toInt() == 0 ||
        value.toInt() == readings.length - 1 ||
        value.toInt() == (readings.length - 1) / 2) {
      return Text(
          DateUtility.formatDateTime(
              dateTime: readings[value.toInt()].TimeStamp,
              outputFormat: "dd MMM"),
          style: const TextStyle(fontSize: 8, color: Colors.black));
    } else {
      return const SizedBox();
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int count = 5;
    int interval = readings.length ~/ count;
    int listLength = readings.length - 1;
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.white,
      fontSize: 8,
    );
    String formatter = "HH:mm a";
    if (pageType == "WEEK" || pageType == "MONTH") {
      formatter = "dd MMM";
    } else {
      formatter = "HH:mm a";
    }
    Widget text = Container();
    if (value.toInt() == 0) {
      text = Text(DateFormat(formatter).format(readings.elementAt(0).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength / 2) {
      text = Text(
          DateFormat(formatter).format(
              readings.elementAt((listLength / 2 - 1).toInt()).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength ~/ 4) {
      text = Text(
          DateFormat(formatter)
              .format(readings.elementAt((listLength / 4).toInt()).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength ~/ 1.33) {
      text = Text(
          DateFormat(formatter)
              .format(readings.elementAt(listLength ~/ 1.33).TimeStamp),
          style: style);
    } else if (value.toInt() == listLength) {
      text = Text(
          DateFormat(formatter)
              .format(readings.elementAt(listLength - 1).TimeStamp),
          style: style);
    } else {
      text = Container();
    }
    if (value.toInt() == readings.length / 2) {}

    return SideTitleWidget(
      space: 2,
      fitInside: SideTitleFitInsideData.fromTitleMeta(
        meta,
        distanceFromEdge: -10,
      ),
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Map<String, double> prepareData() {
    //find activity with highest value
    final highestValue = readings.reduce((current, next) =>
        current.ReadingMax > next.ReadingMax ? current : next);
    return {
      "highestValue": highestValue.ReadingMax,
      "yInterval": getInterval(highestValue.ReadingMax.toInt(), parts: 4),
      "xInterval": getInterval(readings.length, parts: 5).toInt().toDouble()
    };
  }

  double getInterval(int max, {int parts = 6}) {
    if (width == double.infinity) {
      return max / parts;
    } else {
      return max / 3;
    }
  }

  var labels = [];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.white,
      fontSize: 8,
    );
    String text = "";

    if (labels.isEmpty) {
      labels.add(value);
    }

    if (medicalCode == "BT") {
      text = Utils.convertTemp(value, isFarenheit).round().toString();
    } else {
      text = value.toStringAsFixed(0);
    }
    return Text(" $text", style: style, textAlign: TextAlign.left);
    // return SideTitleWidget(
    //   space: 0,
    //   fitInside: SideTitleFitInsideData.fromTitleMeta(
    //     meta,
    //     distanceFromEdge: 0,
    //   ),
    //   axisSide: meta.axisSide,
    //   child: Text(" $text", style: style, textAlign: TextAlign.left),
    // );
  }

  // void getYAxisValues(int count){
  //   double range = yMax - yMin;
  //   double interval = range / count;
  //   for(int i = 0; i <= count; i++){
  //     yValues.add(yMin + (interval * i));
  //   }
  // }

  double getTemperatureValue(double valueInCelcius) {
    final isFarenheit = getIt<GlobalConfiguration>().isFarenheit;
    if (isFarenheit) {
      unit = "°F";
      return (valueInCelcius * 9 / 5) + 32;
    } else {
      unit = "°C";
      return valueInCelcius.toDouble();
    }
  }
}
