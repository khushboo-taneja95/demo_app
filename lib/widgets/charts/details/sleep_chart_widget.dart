// import 'package:flutter/material.dart';
// import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
// import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
// import 'package:tres_connect/widgets/charts/details/sleep_chart.dart';

// class SleepChartWidget extends StatelessWidget {
//   final List<ActivityDetails> sleepDetails;
//   final List<HealthReading> hrReadings;
//   final bool isDarkBackground;

//   const SleepChartWidget(
//       {super.key,
//       required this.sleepDetails,
//       required this.hrReadings,
//       this.isDarkBackground = false});

//   @override
//   Widget build(BuildContext context) {
//     if (sleepDetails.isNotEmpty && hrReadings.isNotEmpty) {
//       return SleepChart(
//         sleepDetails: sleepDetails,
//         hrReadings: hrReadings,
//         isDarkBackground: isDarkBackground,
//       );
//     } else {
//       return const SizedBox(
//         height: 150,
//         child: Center(
//           child: Text("No data available"),
//         ),
//       );
//     }
//   }
// }
