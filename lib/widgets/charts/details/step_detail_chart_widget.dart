// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tres_connect/core/utility/DateUtility.dart';
// import 'package:tres_connect/features/health_dashboard/domain/entities/formatted_db_response.dart';

// class StepDetailChartWidget extends StatelessWidget {
//   final List<FormattedActivityDetailResponse> activity;
//   final String pageType;
//   final Function(int index) onSelected;
//   final String dataType;
//   const StepDetailChartWidget(
//       {Key? key,
//       required this.activity,
//       required this.pageType,
//       required this.onSelected,
//       this.dataType = "Step"})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final data = prepareData();
//     print(data);
//     Color barColor = Color(0xff0DB6B8);
//     if (dataType == "Step") {
//       barColor = const Color(0xff0DB6B8);
//     } else if (dataType == "Calorie") {
//       barColor = const Color(0xffF25604);
//     } else if (dataType == "Distance") {
//       barColor = const Color(0xff6959F7);
//       ;
//     }
//     return Container(
//       height: 150,
//       margin: const EdgeInsets.all(10),
//       child: BarChart(BarChartData(
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           horizontalInterval: data['yInterval'] == 0 ? 0.1 : data['yInterval'],
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.grey,
//               strokeWidth: 0.2,
//             );
//           },
//         ),
//         barGroups: List.generate(
//             activity.length,
//             (index) => BarChartGroupData(
//                   x: index,
//                   showingTooltipIndicators: [0],
//                   barRods: [
//                     BarChartRodData(
//                       color: barColor,
//                       width: 260 / activity.length,
//                       borderRadius: BorderRadius.zero,
//                       toY: activity[index].total,
//                     ),
//                   ],
//                 )),
//         titlesData: FlTitlesData(
//           show: true,
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           topTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               interval: 1,
//               getTitlesWidget: (value, meta) {
//                 if (activity.length > 7) {
//                   if (value % (data['xInterval'] as double).toInt() == 0) {
//                     return Text(getXAxisLabel(activity[value.toInt()].hour),
//                         style:
//                             const TextStyle(fontSize: 8, color: Colors.white));
//                   } else {
//                     return const SizedBox();
//                   }
//                 } else {
//                   return Text(getXAxisLabel(activity[value.toInt()].hour),
//                       style: const TextStyle(fontSize: 8, color: Colors.white));
//                 }
//               },
//             ),
//           ),
//           rightTitles: AxisTitles(
//             drawBehindEverything: true,
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 30,
//               interval: data['yInterval'] == 0 ? 0.1 : data['yInterval'],
//               getTitlesWidget: (value, meta) => Text(_getShorthandNumber(value),
//                   style: const TextStyle(fontSize: 8, color: Colors.white)),
//             ),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: const Border(
//             top: BorderSide.none,
//             bottom: BorderSide(color: Colors.grey, width: 0.2),
//             left: BorderSide.none,
//             right: BorderSide(color: Colors.grey, width: 0.2),
//           ),
//         ),
//         barTouchData: BarTouchData(
//             enabled: true,
//             touchTooltipData: BarTouchTooltipData(
//               tooltipBgColor: Colors.transparent,
//               tooltipPadding: EdgeInsets.zero,
//               tooltipMargin: 0,
//               getTooltipItem: (
//                 BarChartGroupData group,
//                 int groupIndex,
//                 BarChartRodData rod,
//                 int rodIndex,
//               ) {
//                 if (activity.length <= 24 && rod.toY != 0) {
//                   return BarTooltipItem(
//                     getBarValueLabel(rod.toY),
//                     const TextStyle(
//                       color: Colors.white,
//                       fontSize: 7,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   );
//                 } else {
//                   return BarTooltipItem(
//                     "",
//                     const TextStyle(
//                       color: Colors.white,
//                       fontSize: 0,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   );
//                 }
//               },
//             ),
//             touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
//               if (response != null && response.spot != null) {
//                 onSelected(response.spot!.touchedBarGroupIndex);
//               }
//             }),
//       )),
//     );
//   }

//   String getBarValueLabel(double value) {
//     if (dataType == 'Step') {
//       return value.round().toStringAsFixed(0);
//     } else if (dataType == 'Calorie' || dataType == 'Distance') {
//       return value.toStringAsFixed(2);
//     } else if (dataType == 'Sleep') {
//       return DateUtility.convertMinutesToHours(value.round(),
//           showInTwoDigits: false, shrink: true);
//     } else {
//       return value.toString();
//     }
//   }

//   Map<String, double> prepareData() {
//     //find activity with highest value
//     final highestValue = activity
//         .reduce((current, next) => current.total > next.total ? current : next);
//     print("Highest Value: ${highestValue.total} on ${highestValue.hour}");

//     return {
//       "highestValue": highestValue.total,
//       "yInterval": getInterval(highestValue.total.toInt(), parts: 7),
//       "xInterval": getInterval(activity.length, parts: 7).toInt().toDouble()
//     };
//   }

//   double getInterval(int max, {int parts = 6}) {
//     return max / parts;
//   }

//   String _getShorthandNumber(double number) {
//     if (number >= 1000 && number < 1000000) {
//       double result = number / 1000;
//       return '${result.toStringAsFixed(1)}k';
//     } else if (number >= 1000000) {
//       double result = number / 1000000;
//       return '${result.toStringAsFixed(1)}m';
//     } else {
//       return number.toStringAsFixed(1);
//     }
//   }

//   String getXAxisLabel(int hour) {
//     if (hour == 0) {
//       return "12 AM";
//     }
//     if (hour == 12) {
//       return "12 PM";
//     }
//     if (hour > 12) {
//       return "${hour - 12} PM";
//     } else {
//       return "$hour AM";
//     }
//   }

//   String formatNumber(double numberToFormat) {
//     var _formattedNumber = NumberFormat.compactCurrency(
//       decimalDigits: 1,
//       symbol:
//           '', // if you want to add currency symbol then pass that in this else leave it empty.
//     ).format(numberToFormat);
//     return _formattedNumber;
//   }

//   List<int> divideNumber(int number, int n) {
//     List<int> parts = [];
//     int increment = ((number - 1) / (n - 1)).round();
//     for (int i = 0; i < n; i++) {
//       int value = 1 + (increment * i);
//       if (i == n - 1) {
//         value = number;
//       }
//       parts.add(value);
//     }
//     return parts;
//   }
// }
