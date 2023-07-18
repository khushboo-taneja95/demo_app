// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:tres_connect/core/constants/watch_constants.dart';
// import 'package:tres_connect/core/database/database.dart';
// import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
// import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
// import 'package:tres_connect/core/di/injection.dart';
// import 'package:tres_connect/core/errors/failures.dart';
// import 'package:tres_connect/core/usecase/usecase.dart';
// import 'package:tres_connect/features/health_dashboard/domain/repositories/activity_repository.dart';
// import 'package:tres_connect/global_configuration.dart';

// class SaveActivityUseCase extends UseCase<void, SaveActivityParams> {
//   final ActivityRepository repository;

//   SaveActivityUseCase({required this.repository});

//   @override
//   Future<Either<Failure, void>> call(SaveActivityParams params) async {
//     //Check if watch is tres or other watch
//     //If tres watch, save to local db
//     //If other watch, save to activity summary and then create a new activity detail based on the last entry to the database

//     try {
//       if (WatchConstants.isTresWatch(params.deviceName)) {
//         return repository.saveActivitySummary(detailsList: params.summaryList);
//       } else if (WatchConstants.compareDeviceName(
//           params.deviceName, WatchConstants.ULTRA_WATCH)) {
//         final newData =
//             await formatActivityDetailsFromLastSummary(params.summaryList);
//         repository.saveActivityDetails(detailsList: newData);
//         return repository.saveActivitySummary(detailsList: params.summaryList);
//       } else {
//         return repository.saveActivitySummary(detailsList: params.summaryList);
//       }
//     } catch (e) {
//       return Left(DatabaseException(e.toString()));
//     }
//   }

//   Future<List<ActivityDetails>> formatActivityDetailsFromLastSummary(
//       List<ActivitySummary> details) async {
//     List<ActivityDetails> newDetails = [];
//     String uid = getIt<GlobalConfiguration>().profile.uID!;
//     var lastStepSummary =
//         await getIt<AppDatabase>().activitySummaryDao.getLastSummary("Step");
//     var lastCalorieSummary =
//         await getIt<AppDatabase>().activitySummaryDao.getLastSummary("Calorie");
//     var lastDistanceSummary = await getIt<AppDatabase>()
//         .activitySummaryDao
//         .getLastSummary("Distance");

//     double lastStepValue = lastStepSummary?.ActivityValue ?? 0;
//     double lastCalorieValue = lastCalorieSummary?.ActivityValue ?? 0;
//     double lastDistanceValue = lastDistanceSummary?.ActivityValue ?? 0;

//     for (int i = 0; i < details.length; i++) {
//       if (details[i].ActivityType == "Step") {
//         if (details[i].ActivityValue - lastStepValue > 0) {
//           newDetails.add(ActivityDetails(
//               UID: uid,
//               ActivityType: details[i].ActivityType,
//               ActivityStartDate: DateTime.now(),
//               ActivityEndDate: DateTime.now().add(const Duration(minutes: 10)),
//               date: DateTime.now().toString(),
//               ActivityValue: details[i].ActivityValue - lastStepValue,
//               DeviceType: details[i].DeviceType,
//               IsSynced: false,
//               IsGoogleFitSync: false));
//         }
//       } else if (details[i].ActivityType == "Calorie") {
//         if (details[i].ActivityValue - lastCalorieValue > 0) {
//           newDetails.add(ActivityDetails(
//               UID: uid,
//               ActivityType: details[i].ActivityType,
//               ActivityStartDate: DateTime.now(),
//               ActivityEndDate: DateTime.now().add(const Duration(minutes: 10)),
//               date: DateTime.now().toString(),
//               ActivityValue: details[i].ActivityValue - lastCalorieValue,
//               DeviceType: details[i].DeviceType,
//               IsSynced: false,
//               IsGoogleFitSync: false));
//         }
//       } else if (details[i].ActivityType == "Distance") {
//         if (details[i].ActivityValue - lastDistanceValue > 0) {
//           newDetails.add(ActivityDetails(
//               UID: uid,
//               ActivityType: details[i].ActivityType,
//               ActivityStartDate: DateTime.now(),
//               ActivityEndDate: DateTime.now().add(const Duration(minutes: 10)),
//               date: DateTime.now().toString(),
//               ActivityValue: details[i].ActivityValue - lastDistanceValue,
//               DeviceType: details[i].DeviceType,
//               IsSynced: false,
//               IsGoogleFitSync: false));
//         }
//       }
//     }
//     return newDetails;
//   }
// }

// class SaveActivityParams extends Equatable {
//   final List<ActivitySummary> summaryList;
//   final String deviceName;

//   const SaveActivityParams(
//       {required this.summaryList, required this.deviceName});

//   @override
//   List<Object?> get props => throw UnimplementedError();
// }
