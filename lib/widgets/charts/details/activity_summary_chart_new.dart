// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mp_chart/mp/chart/bar_chart.dart';
// import 'package:mp_chart/mp/controller/bar_chart_controller.dart';
// import 'package:mp_chart/mp/core/data/bar_data.dart';
// import 'package:mp_chart/mp/core/data_interfaces/i_bar_data_set.dart';
// import 'package:mp_chart/mp/core/data_set/bar_data_set.dart';
// import 'package:mp_chart/mp/core/description.dart';
// import 'package:mp_chart/mp/core/entry/bar_entry.dart';
// import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
// import 'package:mp_chart/mp/core/enums/y_axis_label_position.dart';
// import 'package:mp_chart/mp/core/utils/color_utils.dart';
// import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
// import 'package:tres_connect/core/utility/DateUtility.dart';
// import 'package:tres_connect/core/utility/utils.dart';
// import 'package:tres_connect/widgets/charts/details/MyValueFormatter.dart';

// class ActivitySummaryChart extends StatefulWidget {
//   final List<ActivitySummary> summaries;
//   final double height;
//   final double width;
//   final bool showLabelsAboveBars;
//   final int xAxisLabelCount;
//   final Color barColor;
//   final Color labelColor;
//   const ActivitySummaryChart(
//       {Key? key,
//       required this.summaries,
//       this.width = double.infinity,
//       this.height = 200,
//       this.showLabelsAboveBars = true,
//       this.xAxisLabelCount = 4,
//       this.barColor = ColorUtils.HOLO_BLUE_DARK,
//       this.labelColor = Colors.grey})
//       : super(key: key);

//   @override
//   State<ActivitySummaryChart> createState() => _ActivitySummaryChartState();
// }

// class _ActivitySummaryChartState extends State<ActivitySummaryChart> {
//   BarChartController? controller;

//   @override
//   void initState() {
//     _initController();
//     _initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       width: widget.width,
//       child: _getChart(),
//     );
//   }

//   void _initController() {
//     var desc = Description()..enabled = false;
//     controller = BarChartController(
//       backgroundColor: Colors.transparent,
//       minOffset: 10,
//       axisLeftSettingFunction: (axisLeft, controller) {
//         axisLeft!
//           ..enabled = false
//           ..setLabelCount2(8, false)
//           // ..setValueFormatter(MyValueFormatter("\$"))
//           ..position = YAxisLabelPosition.OUTSIDE_CHART
//           ..spacePercentTop = 15
//           ..setAxisMinimum(0);
//       },
//       axisRightSettingFunction: (axisRight, controller) {
//         axisRight!
//           ..setValueFormatter(MyValueFormatter((value) {
//             if (value != null) {
//               if (widget.summaries.first.ActivityType == "Sleep") {
//                 return DateUtility.convertMinutesToHours(value.toInt(),
//                     showInTwoDigits: false, shrink: true);
//               } else {
//                 return Utils.getPrettyNumber(value);
//               }
//             } else {
//               return "";
//             }
//           }))
//           ..textColor = widget.labelColor
//           ..textSize = 9
//           ..drawGridLines = false
//           ..setLabelCount1(7)
//           ..spacePercentTop = 15
//           ..drawGridLines = true
//           ..gridLineWidth = 0.3
//           ..setAxisMinimum(0);
//       },
//       legendSettingFunction: (legend, controller) {
//         legend!.enabled = false;
//       },
//       xAxisSettingFunction: (xAxis, controller) {
//         xAxis!
//           // ..typeface = Util.LIGHT
//           ..setValueFormatter(MyValueFormatter((value) {
//             if (value != null && value.toInt() < widget.summaries.length) {
//               return DateUtility.formatDateTime(
//                   dateTime: widget.summaries[value.toInt()].ActivityDate,
//                   outputFormat: 'dd MMM');
//             } else {
//               return "";
//             }
//           }))
//           ..textColor = widget.labelColor
//           ..textSize = 9
//           ..yOffset = -20
//           ..xOffset = -10
//           ..position = XAxisPosition.BOTTOM
//           ..drawGridLines = false
//           ..setLabelCount1(widget.summaries.length == 7 ? 7 : 5)
//           ..setGranularity(0.8);
//         // ..setValueFormatter(DayAxisValueFormatter(controller as BarLineScatterCandleBubbleController<BarLineChartBasePainter<BarLineScatterCandleBubbleData<IBarLineScatterCandleBubbleDataSet<Entry?>>?>>));
//       },
//       drawBarShadow: false,
//       drawValueAboveBar: widget.showLabelsAboveBars,
//       drawGridBackground: false,
//       dragXEnabled: false,
//       dragYEnabled: false,
//       scaleXEnabled: false,
//       scaleYEnabled: false,
//       pinchZoomEnabled: false,
//       maxVisibleCount: 50,
//       description: desc,
//     );
//   }

//   void _initData() {
//     List<BarEntry> values = [];

//     for (int i = 0; i < widget.summaries.length; i++) {
//       values
//           .add(BarEntry(x: i.toDouble(), y: widget.summaries[i].ActivityValue));
//     }

//     BarDataSet set1;

//     set1 = BarDataSet(values, "Steps");

//     set1.setDrawIcons(false);
//     set1.setDrawValues(widget.showLabelsAboveBars);
//     set1.setValueTextColor(widget.labelColor);
//     set1.setColors1([widget.barColor]);
//     List<IBarDataSet> dataSets = [];
//     dataSets.add(set1);
//     final barData = BarData(dataSets);
//     barData.setValueTextSize(10);
//     barData.setValueFormatter(MyValueFormatter((value) {
//       if (value != null && value != 0 && widget.summaries.isNotEmpty) {
//         if (widget.summaries.first.ActivityType == "Sleep") {
//           return DateUtility.convertMinutesToHours(value.toInt(),
//               showInTwoDigits: false, shrink: true);
//         } else {
//           return value.toStringAsFixed(0);
//         }
//       } else {
//         return "";
//       }
//     }));

//     controller!.data = barData;
//     controller!.data!
//       ..setValueTextSize(7)
//       ..barWidth = 0.9;
//     setState(() {});
//   }

//   Widget _getChart() {
//     if (controller == null || controller!.data == null) {
//       return Container(
//         width: widget.width,
//         height: widget.height,
//         color: Colors.red,
//       );
//     }
//     var lineChart = BarChart(controller!);
//     controller!.animator!
//       ..reset()
//       ..animateX1(1500);
//     return lineChart;
//   }
// }
