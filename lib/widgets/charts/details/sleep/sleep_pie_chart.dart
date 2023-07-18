// import 'package:flutter/material.dart';
// import 'package:mp_chart/mp/chart/pie_chart.dart';
// import 'package:mp_chart/mp/controller/pie_chart_controller.dart';
// import 'package:mp_chart/mp/core/adapter_android_mp.dart';
// import 'package:mp_chart/mp/core/data/pie_data.dart';
// import 'package:mp_chart/mp/core/data_set/pie_data_set.dart';
// import 'package:mp_chart/mp/core/description.dart';
// import 'package:mp_chart/mp/core/entry/pie_entry.dart';
// import 'package:mp_chart/mp/core/poolable/point.dart';
// import 'package:mp_chart/mp/core/render/pie_chart_renderer.dart';
// import 'package:mp_chart/mp/core/utils/color_utils.dart';
// import 'package:tres_connect/core/themes/palette.dart';

// class SleepPieChart extends StatefulWidget {
//   final double deepSleepPercentage, lightSleepPercentage, remSleepPercentage, awakeSleepPercentage;
//   const SleepPieChart({Key? key,required this.deepSleepPercentage, required this.lightSleepPercentage, required this.remSleepPercentage, required this.awakeSleepPercentage}) : super(key: key);

//   @override
//   State<SleepPieChart> createState() => _SleepPieChartState();
// }

// class _SleepPieChartState extends State<SleepPieChart> {

//   PieChartController? controller;

//   @override
//   void initState() {
//     _initController();
//     _initPieData(4);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: PieChart(controller!),
//     );
//   }

//   void _initController() {
//     var desc = Description()
//       ..text = "desc"
//       ..enabled = true;
//     controller = PieChartController(
//         legendSettingFunction: (legend, controller) {
//           legend!.enabled = false;
//         },
//         rendererSettingFunction: (renderer) {
//           (renderer as PieChartRenderer)

//             ..setHoleColor(ColorUtils.WHITE)
//             ..setTransparentCircleColor(ColorUtils.WHITE)
//             ..setTransparentCircleAlpha(110)
//             ..setEntryLabelColor(ColorUtils.WHITE)
//             ..setEntryLabelTextSize(12);
//         },
//         rotateEnabled: true,
//         drawHole: true,
//         drawCenterText: false,
//         drawEntryLabels: false,
//         extraLeftOffset: 5,
//         extraTopOffset: 10,
//         extraRightOffset: 5,
//         extraBottomOffset: 5,
//         usePercentValues: false,
//         centerText: "Sleep",
//         minOffset: 0,
//         highLightPerTapEnabled: false,
//         holeRadiusPercent: 90.0,
//         transparentCircleRadiusPercent: 100,

//         description: desc);
//   }

//   void _initPieData(int count) async {
//     List<PieEntry> entries = [];
//     entries.add(PieEntry(value: widget.deepSleepPercentage, label: "Deep Sleep", labelColor: Palette.deepSleepColor));
//     entries.add(PieEntry(value: widget.lightSleepPercentage, label: "Light Sleep", labelColor: Palette.lightSleepColor));
//     entries.add(PieEntry(value: widget.remSleepPercentage, label: "REM Sleep", labelColor: Palette.remSleepColor));
//     entries.add(PieEntry(value: widget.awakeSleepPercentage, label: "Awake", labelColor: Palette.awakeSleepColor));


//     PieDataSet dataSet = PieDataSet(entries, "Election Results");

//     dataSet.setDrawIcons(false);

//     dataSet.setSliceSpace(3);
//     dataSet.setSelectionShift(5);
//     dataSet.setDrawValues(false);
//     // add a lot of colors
//     List<Color> colors = [Palette.deepSleepColor, Palette.lightSleepColor, Palette.remSleepColor, Palette.awakeSleepColor];
//     // for (Color c in ColorUtils.VORDIPLOM_COLORS) colors.add(c);
//     // for (Color c in ColorUtils.JOYFUL_COLORS) colors.add(c);
//     // for (Color c in ColorUtils.COLORFUL_COLORS) colors.add(c);
//     // for (Color c in ColorUtils.LIBERTY_COLORS) colors.add(c);
//     // for (Color c in ColorUtils.PASTEL_COLORS) colors.add(c);
//     // colors.add(ColorUtils.HOLO_BLUE);
//     dataSet.setColors1(colors);

//     controller!.data = PieData(dataSet);
//     controller!.data!
//       ..setValueTextSize(11)
//       ..setValueTextColor(ColorUtils.WHITE)
//       ..setValueTypeface(TypeFace(fontFamily: "OpenSans", fontWeight: FontWeight.w400));

//     setState(() {});
//   }
// }
