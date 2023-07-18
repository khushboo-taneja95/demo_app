// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tres_connect/core/database/database.dart';
// import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
// import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
// import 'package:tres_connect/core/di/injection.dart';
// import 'package:tres_connect/core/errors/failures.dart';
// import 'package:tres_connect/core/usecase/usecase.dart';
// import 'package:tres_connect/global_configuration.dart';
// import 'package:watch_sdk/response.dart';

// class SaveRealtimeActivityUseCase extends UseCase<bool, SDKResponse> {
//   @override
//   Future<Either<Failure, bool>> call(SDKResponse response) async {
//     try {
//       debugPrint("SaveRealtimeActivityUseCase Invoked");
//       String uid = getIt<GlobalConfiguration>().profile.uID ?? "";
//       var lastStepDetail =
//           await getIt<AppDatabase>().activityDetailsDao.getLastDetails("Step");
//       var lastCalorieDetail = await getIt<AppDatabase>()
//           .activityDetailsDao
//           .getLastDetails("Calorie");
//       var lastDistanceDetail = await getIt<AppDatabase>()
//           .activityDetailsDao
//           .getLastDetails("Distance");

//       double lastStepValue = lastStepDetail?.ActivityValue ?? 0;
//       double lastCalorieValue = lastCalorieDetail?.ActivityValue ?? 0;
//       double lastDistanceValue = lastDistanceDetail?.ActivityValue ?? 0;

//       List<ActivityDetails> detailsList = [];
//       for (var data in response.getListMapFromData()) {
//         var startTime = DateTime.fromMicrosecondsSinceEpoch(
//             (data['startTime'] as int) * 1000);
//         var endTime = DateTime.fromMicrosecondsSinceEpoch(
//             (data['endTime'] as int) * 1000);

//         double value = data['value'] as double;

//         if (data['type'] == "Step") {
//           value = value - (lastStepValue);
//           lastStepValue += value;
//         } else if (data['type'] == "Calorie") {
//           value = value - (lastCalorieValue);
//           lastCalorieValue += value;
//         } else if (data['type'] == "Distance") {
//           value = value - (lastDistanceValue);
//           lastDistanceValue += value;
//         }
//         if (value > 0) {
//           detailsList.add(ActivityDetails(
//               UID: uid,
//               ActivityStartDate: startTime,
//               ActivityEndDate: endTime,
//               date: DateFormat("yyyy-MM-dd HH:mm:ss").format(startTime),
//               ActivityType: data['type'] as String? ?? "",
//               ActivityValue: value,
//               IsAutomatedReading: true,
//               IsSynced: false,
//               IsGoogleFitSync: false,
//               DeviceType: response.deviceName ?? ""));
//         }
//       }
//       await getIt<AppDatabase>()
//           .activityDetailsDao
//           .insertAllDetails(detailsList);

//       List<ActivitySummary> summaryList = [];
//       for (var data in response.getListMapFromData()) {
//         var startTime = DateTime.fromMicrosecondsSinceEpoch(
//             (data['startTime'] as int) * 1000);
//         summaryList.add(ActivitySummary(
//             UID: uid,
//             ActivityDate: startTime,
//             ActivityTotalTime: data['duration'] as int,
//             date: DateFormat("yyyy-MM-dd 00:00:00").format(startTime),
//             ActivityType: data['type'] as String? ?? "",
//             ActivityValue: data['value'] as double,
//             IsAutomatedReading: true,
//             IsSynced: false,
//             IsGoogleFitSync: false,
//             DeviceType: response.deviceName ?? ""));
//         await getIt<AppDatabase>()
//             .activitySummaryDao
//             .insertAllSummary(summaryList);
//       }
//       return const Right(true);
//     } catch (e) {
//       debugPrint("SaveRealtimeActivityUseCase exception: $e");
//       return Left(DatabaseException(e.toString()));
//     }
//   }
// }
