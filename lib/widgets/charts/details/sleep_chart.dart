// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:mp_chart/mp/chart/bar_chart.dart';
// import 'package:mp_chart/mp/chart/line_chart.dart';
// import 'package:mp_chart/mp/controller/bar_chart_controller.dart';
// import 'package:mp_chart/mp/controller/line_chart_controller.dart';
// import 'package:mp_chart/mp/core/adapter_android_mp.dart';
// import 'package:mp_chart/mp/core/axis/y_axis.dart';
// import 'package:mp_chart/mp/core/data/bar_data.dart';
// import 'package:mp_chart/mp/core/data/line_data.dart';
// import 'package:mp_chart/mp/core/data_interfaces/i_bar_data_set.dart';
// import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
// import 'package:mp_chart/mp/core/data_set/bar_data_set.dart';
// import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
// import 'package:mp_chart/mp/core/description.dart';
// import 'package:mp_chart/mp/core/entry/bar_entry.dart';
// import 'package:mp_chart/mp/core/entry/entry.dart';
// import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
// import 'package:mp_chart/mp/core/enums/legend_form.dart';
// import 'package:mp_chart/mp/core/enums/mode.dart';
// import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
// import 'package:mp_chart/mp/core/utils/color_utils.dart';
// import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
// import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
// import 'package:tres_connect/widgets/charts/details/date_time_value_formatter.dart';
// import 'package:tres_connect/widgets/charts/details/sleep/sleep_range_info.dart';

// class SleepChart extends StatefulWidget {
//   final List<HealthReading> hrReadings;
//   final List<ActivityDetails> sleepDetails;
//   final double height;
//   final bool isDarkBackground;
//   const SleepChart(
//       {super.key,
//       required this.hrReadings,
//       required this.sleepDetails,
//       this.height = 200,
//       this.isDarkBackground = false});

//   @override
//   State<SleepChart> createState() => _SleepChartState();
// }

// class _SleepChartState extends State<SleepChart> {
//   LineChartController? controller;
//   BarChartController? awakeBarChartController;
//   var random = Random(1);
//   int _count = 45;
//   double _range = 180.0;

//   int to = 0, from = 0;

//   //Range Information
//   List<SleepRangeInfo> deepSleepRange = [];
//   List<SleepRangeInfo> lightSleepRange = [];
//   List<SleepRangeInfo> remSleepRange = [];
//   List<BarEntry> awakeBarEntries = [];

//   //Entries
//   List<Entry> hrEntries = [];
//   List<Entry> deepSleepEntries = [];
//   List<Entry> lightSleepEntries = [];
//   List<Entry> remSleepEntries = [];

//   //DataSets
//   List<LineDataSet> deepSleepDataSet = [];
//   List<LineDataSet> lightSleepDataSet = [];
//   List<LineDataSet> remSleepDataSet = [];

//   @override
//   void initState() {
//     _initController();
//     _initLineData(_count, _range);
//     _initBarData();
//     super.initState();
//   }

//   Widget getBody() {
//     return SizedBox(
//       height: widget.height,
//       child: Stack(
//         children: [
//           _initLineChart(),
//           Positioned(
//               top: 0, left: 0, right: 0, bottom: 4, child: _awakeBarChart()),
//         ],
//       ),
//     );
//   }

//   String getTitle() {
//     return "Line Chart Basic";
//   }

//   void _initController() {
//     var desc = Description()..enabled = false;
//     controller = LineChartController(
//         axisLeftSettingFunction: (axisLeft, controller) {
//           axisLeft!.enabled = false;
//         },
//         axisRightSettingFunction: (axisRight, controller) {
//           axisRight!
//             ..drawLimitLineBehindData = true
//             ..setLabelCount2(5, true)
//             ..drawGridLines = false
//             ..textColor = widget.isDarkBackground ? Colors.white : Colors.black
//             ..setDrawZeroLine(true);
//         },
//         axisLeft: YAxis(position: AxisDependency.LEFT),
//         legendSettingFunction: (legend, controller) {
//           legend!.enabled = false;
//           legend.shape = (LegendForm.SQUARE);
//         },
//         xAxisSettingFunction: (xAxis, controller) {
//           xAxis!
//             ..setValueFormatter(TimeValueFormatter())
//             ..position = (XAxisPosition.BOTTOM)
//             ..drawGridLines = false
//             ..setLabelCount2(5, true)
//             ..drawLimitLineBehindData = false
//             ..textColor = widget.isDarkBackground ? Colors.white : Colors.black
//             ..yOffset = 10;
//           // ..enableAxisLineDashedLine(5, 5, 0);
//           // ..enableGridDashedLine(10, 10, 0);
//         },
//         drawGridBackground: false,
//         backgroundColor: Colors.transparent,
//         dragXEnabled: false,
//         dragYEnabled: false,
//         scaleXEnabled: false,
//         scaleYEnabled: false,
//         pinchZoomEnabled: false,
//         description: desc);
//   }

//   void populateSleepData() {
//     for (var subdata in widget.hrReadings) {
//       if (subdata.TimeStamp != null) {
//         bool isAwake = true;
//         double y = subdata.ReadingMax;
//         double x =
//             (subdata.TimeStamp.millisecondsSinceEpoch ~/ 1000).toDouble();

//         if (isRange(x, deepSleepRange)) {
//           deepSleepEntries.add(Entry(x: x, y: y, data: "Deep"));
//         } else {
//           if (deepSleepEntries.isNotEmpty) {
//             if (deepSleepEntries.length == 1) {
//               deepSleepEntries.add(Entry(x: x, y: y, data: "Deep"));
//             }
//             deepSleepDataSet.add(LineDataSet(deepSleepEntries, "Deep"));
//             deepSleepEntries = [];
//           }
//         }
//         if (isRange(x, lightSleepRange)) {
//           lightSleepEntries.add(Entry(x: x, y: y, data: "Light"));
//         } else {
//           if (lightSleepEntries.isNotEmpty) {
//             if (lightSleepEntries.length == 1) {
//               lightSleepEntries.add(Entry(x: x, y: y, data: "Light"));
//             }
//             lightSleepDataSet.add(LineDataSet(lightSleepEntries, "Light"));
//             lightSleepEntries = [];
//           }
//         }
//         if (isRange(x, remSleepRange)) {
//           remSleepEntries.add(Entry(x: x, y: y, data: "REM"));
//         } else {
//           if (remSleepEntries.isNotEmpty) {
//             if (remSleepEntries.length == 1) {
//               remSleepEntries.add(Entry(x: x, y: y, data: "REM"));
//             }
//             remSleepDataSet.add(LineDataSet(remSleepEntries, "REM"));
//             remSleepEntries = [];
//           }
//         }
//         if (x > from) {
//           hrEntries.add(Entry(x: x, y: y, data: "Disturbed"));
//         }
//       }
//     }
//   }

//   Widget _awakeBarChart() {
//     var lineChart = BarChart(awakeBarChartController!);
//     awakeBarChartController!.animator!
//       ..reset()
//       ..animateX1(1500);
//     return lineChart;
//   }

//   void _initBarData() async {
//     awakeBarChartController = BarChartController(
//       axisLeftSettingFunction: (axisLeft, controller) {
//         axisLeft!
//           ..setAxisMaximum(180)
//           ..setAxisMinimum(0)
//           ..enabled = false;
//       },
//       axisRightSettingFunction: (axisRight, controller) {
//         axisRight!.enabled = false;
//       },
//       legendSettingFunction: (legend, controller) {
//         legend!.enabled = false;
//         legend.shape = (LegendForm.SQUARE);
//       },
//       xAxisSettingFunction: (xAxis, controller) {
//         xAxis!..enabled = false;
//       },
//       drawGridBackground: false,
//       backgroundColor: Colors.transparent,
//       dragXEnabled: false,
//       dragYEnabled: false,
//       scaleXEnabled: false,
//       scaleYEnabled: false,
//       pinchZoomEnabled: false,
//       touchEventListener: null,
//     );
//     BarDataSet set1 = BarDataSet(awakeBarEntries, "Awake");
//     set1.setDrawIcons(false);

//     // draw dashed line
//     //set1.enableDashedLine(10, 5, 0);
//     set1.xMin = 0;
//     set1.xMax = widget.sleepDetails.length.toDouble();
//     set1.setColors1([Colors.red]);
//     set1.setDrawValues(false);
//     List<IBarDataSet> dataSets = [];
//     dataSets.add(set1);
//     final barData = BarData(dataSets);
//     barData.barWidth = 0.4;
//     awakeBarChartController!.data = barData;
//     setState(() {});
//   }

//   void _initLineData(int count, double range) async {
//     LineDataSet set1;
//     from = widget.sleepDetails.first.ActivityStartDate.millisecondsSinceEpoch ~/
//         1000;
//     to =
//         widget.sleepDetails.last.ActivityEndDate.millisecondsSinceEpoch ~/ 1000;

//     formatSleepData();
//     populateSleepData();
//     // deepSleepDataSet = LineDataSet(deepSleepValues, "Deep Sleep");
//     // deepSleepDataSet.setColor1(Colors.green);
//     // deepSleepDataSet.setDrawCircles(false);
//     // deepSleepDataSet.setGradientColor(Colors.red, Colors.pink);
//     // deepSleepDataSet.setDrawFilled(true);
//     // deepSleepDataSet.setDrawValues(false);
//     // create a dataset and give it a type
//     set1 = LineDataSet(hrEntries, "HR");
//     set1.setMode(Mode.HORIZONTAL_BEZIER);
//     set1.setDrawIcons(false);

//     // draw dashed line
//     //set1.enableDashedLine(10, 5, 0);
//     set1.xMin = from.toDouble();
//     set1.xMax = to.toDouble();
//     // black lines and points
//     set1.setColor1(ColorUtils.WHITE);
//     set1.setCircleColor(ColorUtils.WHITE);
//     set1.setDrawCircles(false);
//     set1.setHighLightColor(ColorUtils.PURPLE);
//     set1.setValueFormatter(TimeValueFormatter());
//     // line thickness and point size
//     set1.setLineWidth(1);
//     set1.setCircleRadius(3);

//     // draw points as solid circles
//     set1.setDrawCircleHole(false);

//     // customize legend entry
//     set1.setFormLineWidth(2);
//     set1.setFormLineDashEffect(DashPathEffect(10, 5, 0));
//     set1.setFormSize(15);
//     set1.setLineWidth(2);
//     // text size of values
//     set1.setValueTextSize(9);
//     set1.setDrawValues(false);

//     // draw selection line as dashed
//     set1.enableDashedHighlightLine(10, 5, 0);

//     // set the filled area
//     set1.setDrawFilled(true);
// //    set1.setFillFormatter(A(lineChart.painter));

//     // set color of filled area
//     // set1.setGradientColor(Color(0xffdddddd), Color(0xffdddddd));
//     set1.setColor1(Colors.grey.withAlpha(60));
//     set1.setFillColor(Colors.grey);
//     // set1.setGradientColor(Color(0xff000000), Color(0x90000000));
//     // set1.setGradientColors([Color(0xffc9cacc), Color(0x99c9cacc), Color(0x00FFFFFF)]);

//     List<ILineDataSet> dataSets = [];
//     dataSets.add(set1);

//     //deep sleep data set
//     for (var tempDataSet in deepSleepDataSet) {
//       tempDataSet.setMode(Mode.HORIZONTAL_BEZIER);
//       tempDataSet.setDrawValues(false);
//       tempDataSet.setColor1(Color(0xff0a8bfb));
//       tempDataSet.setLineWidth(2);
//       tempDataSet.setDrawCircles(false);
//       tempDataSet.setDrawFilled(true);
//       tempDataSet.setGradientColor(Color(0xff0a8bfb), Color(0xff0a8bfb));
//       // tempDataSet.setFillDrawable(ApplicationController.getInstance().getResources().getDrawable(R.drawable.deep_sleep_gradient));
//       dataSets.add(tempDataSet);
//     }

//     //light sleep data set
//     for (var tempDataSet in lightSleepDataSet) {
//       tempDataSet.setMode(Mode.HORIZONTAL_BEZIER);
//       tempDataSet.setDrawValues(false);
//       tempDataSet.setColor1(const Color(0xff27c882));
//       tempDataSet.setLineWidth(2);
//       tempDataSet.setDrawCircles(false);
//       tempDataSet.setDrawFilled(true);
//       tempDataSet.setGradientColor(Color(0xff27c882), Color(0xff27c882));
//       //tempDataSet.setFillDrawable(ApplicationController.getInstance().getResources().getDrawable(R.drawable.light_sleep_gradient));
//       dataSets.add(tempDataSet);
//     }

//     //rem sleep data set
//     for (var tempDataSet in remSleepDataSet) {
//       tempDataSet.setMode(Mode.HORIZONTAL_BEZIER);
//       tempDataSet.setDrawValues(false);
//       tempDataSet.setColor1(const Color(0xffbb00ff));
//       tempDataSet.setLineWidth(2);
//       tempDataSet.setDrawCircles(false);
//       tempDataSet.setDrawFilled(true);
//       tempDataSet.setGradientColor(Color(0xffbb00ff), Color(0xffbb00ff));
//       //tempDataSet.setFillDrawable(ApplicationController.getInstance().getResources().getDrawable(R.drawable.rem_sleep_gradient));
//       dataSets.add(tempDataSet);
//     }

//     // add the data sets
//     // dataSets.add(deepSleepDataSet);

//     // create a data object with the data sets
//     controller!.data = LineData.fromList(dataSets);
//     setState(() {});
//   }

//   List<List<ActivityDetails>> getSleepList(List<ActivityDetails> sleepData,
//       {int qualityLessThan = 10}) {
//     List<List<ActivityDetails>> deepSleepList = [];
//     List<ActivityDetails> tempList = [];

//     for (int i = 0; i < sleepData.length; i++) {
//       int sleepQuality = sleepData[i].ActivityValue.toInt();
//       if (sleepQuality < qualityLessThan) {
//         tempList.add(sleepData[i]);
//       } else {
//         if (tempList.isNotEmpty) {
//           deepSleepList.add(tempList);
//           tempList = [];
//         }
//       }
//     }
//     if (tempList.isNotEmpty) {
//       deepSleepList.add(tempList);
//     }
//     return deepSleepList;
//   }

//   Widget _initLineChart() {
//     var lineChart = LineChart(controller!);
//     controller!.animator!
//       ..reset()
//       ..animateX1(1500);
//     return lineChart;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return getBody();
//   }

//   bool isRange(double x, List<SleepRangeInfo> sleepRange) {
//     bool value = false;
//     for (var range in sleepRange) {
//       if (x >= range.startTime && x <= range.endTime) {
//         value = true;
//       }
//     }
//     return value;
//   }

//   void formatSleepData() {
//     List<ActivityDetails> sleepData = widget.sleepDetails;
//     int totalRecords = 0;
//     List<SleepRangeInfo> range = [];

//     for (ActivityDetails detail in sleepData) {
//       int sleepQuality = detail.ActivityValue.toInt();
//       DateTime date = detail.ActivityStartDate;
//       DateTime endDate = detail.ActivityEndDate;

//       if (sleepQuality < 10) {
//         deepSleepRange.add(SleepRangeInfo(date.millisecondsSinceEpoch ~/ 1000,
//             endDate.millisecondsSinceEpoch ~/ 1000));
//       } else if (sleepQuality >= 11 && sleepQuality <= 40) {
//         lightSleepRange.add(SleepRangeInfo(date.millisecondsSinceEpoch ~/ 1000,
//             endDate.millisecondsSinceEpoch ~/ 1000));
//       } else if (sleepQuality >= 41 && sleepQuality <= 99) {
//         remSleepRange.add(SleepRangeInfo(date.millisecondsSinceEpoch ~/ 1000,
//             endDate.millisecondsSinceEpoch ~/ 1000));
//       } else if (sleepQuality >= 100 && sleepQuality <= 255) {
//         awakeBarEntries.add(BarEntry(x: totalRecords.toDouble(), y: 180));
//       }
//       totalRecords++;
//     }
//   }
// }
