import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';

class ActivityUtils {
  // static List<ActivitySummary> fillMissingDates(
  //     List<ActivitySummary> incompleteList,
  //     DateTime startDate,
  //     DateTime endDate) {
  //   if (incompleteList.isEmpty) {
  //     return [];
  //   }
  //   debugPrint('startDate ${startDate} - $endDate');
  //   debugPrint('fillMissingDates: initial length: ${incompleteList.length}');
  //   List<DateTime> allDates = DateUtility.getDatesBetween(startDate, endDate);
  //   debugPrint('total dates: ${allDates.length}');
  //   allDates.forEach((date) {
  //     bool containsDate = incompleteList
  //         .any((obj) => DateUtility.isSameDate(obj.ActivityDate, date));
  //     if (!containsDate) {
  //       incompleteList.add(incompleteList.first.copyWith(
  //           ActivityDate: date,
  //           ActivityValue: 0,
  //           date: DateUtility.formatDateTime(
  //               dateTime: date, outputFormat: 'yyyy-MM-dd')));
  //     }
  //   });
  //   debugPrint('fillMissingDates: final length: ${incompleteList.length}');
  //   incompleteList.sort((a, b) => a.ActivityDate.compareTo(b.ActivityDate));
  //   return incompleteList;
  // }

  static List<ActivitySummary> fillMissingDates(
      List<ActivitySummary> list, DateTime startDate, DateTime endDate) {
    List<ActivitySummary> filledList = [];
    if (list.isEmpty) return list;
    // Sort the list by date
    list.sort((a, b) => a.ActivityDate.compareTo(b.ActivityDate));

    // Get the minimum and maximum dates from the list
    DateTime minDate = startDate;
    DateTime maxDate = endDate;

    // Iterate through the dates between the minimum and maximum dates
    DateTime currentDate = minDate;
    while (currentDate.isBefore(maxDate)) {
      // Check if the current date exists in the list
      ActivitySummary? obj = list.firstWhere((element) {
        return DateUtility.isSameDate(element.ActivityDate, currentDate);
      }, orElse: () {
        return ActivitySummary(
            ActivityDate: currentDate,
            ActivityValue: 0,
            ActivityType: list.last.ActivityType,
            DeviceType: list.last.DeviceType,
            IsGoogleFitSync: list.last.IsGoogleFitSync,
            IsSynced: list.last.IsSynced,
            UID: list.last.UID,
            date: list.last.date,
            ActivityTotalTime: 0,
            IsAutomatedReading: true);
      });

      // If the current date does not exist in the list, add a new object with value as 0
      filledList.add(obj);

      // Move to the next date
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return filledList;
  }

  static List<ActivityDetails> fillMissingHours(
      List<ActivityDetails> incompleteList,
      DateTime startDate,
      DateTime endDate) {
    if (incompleteList.isEmpty) return [];
    debugPrint(
        'startDate ${incompleteList.first.ActivityEndDate} - ${incompleteList.last.ActivityEndDate}');
    debugPrint('fillMissingHours: initial length: ${incompleteList.length}');
    List<DateTime> allDates = DateUtility.getHoursBetween(startDate, endDate);
    allDates.forEach((date) {
      bool containsDate = incompleteList
          .any((obj) => DateUtility.isSameHour(obj.ActivityEndDate, date));
      if (!containsDate) {
        incompleteList.add(incompleteList.first.copyWith(
            ActivityStartDate: date,
            ActivityEndDate: date,
            date: DateUtility.formatDateTime(
                dateTime: date, outputFormat: 'yyyy-MM-dd')));
      }
    });
    debugPrint('fillMissingHours: final length: ${incompleteList.length}');
    return incompleteList;
  }

  static Map<String, dynamic> getSleepDataFromDetails(
      List<ActivityDetails> sleepData) {
    Map<String, int> sleepDetails = {};
    int deepMin = 0, lightMin = 0, remMin = 0, awakeMin = 0, disturbedMin = 0;
    int totalMinutes = 0;

    for (var details in sleepData) {
      double quality = details.ActivityValue;
      int differenceInMin = 0;
      differenceInMin =
          details.ActivityEndDate.difference(details.ActivityStartDate)
              .inMinutes;
      totalMinutes += differenceInMin;
      if (quality <= 10) {
        deepMin += differenceInMin;
      } else if (quality <= 40) {
        lightMin += differenceInMin;
      } else if (quality <= 99) {
        remMin += differenceInMin;
      } else if (quality <= 255) {
        awakeMin += differenceInMin;
      }
    }
    sleepDetails['deepMin'] = deepMin;
    sleepDetails['lightMin'] = lightMin;
    sleepDetails['remMin'] = remMin;
    sleepDetails['awakeMin'] = awakeMin;
    sleepDetails['totalSleep'] = deepMin + lightMin + remMin;
    sleepDetails['timeInBed'] = sleepData.last.ActivityEndDate
        .difference(sleepData.first.ActivityStartDate)
        .inMinutes;
    return sleepDetails;
  }

  static Map<String, dynamic> getSleepDataFromSummary(
      List<ActivitySummary> sleepData) {
    Map<String, int> sleepDetails = {};
    int deepMin = 0, lightMin = 0, remMin = 0, awakeMin = 0, disturbedMin = 0;
    int totalMinutes = 0;
    int totalTimeInBed = 0;
    int totalCount = 0;

    for (var details in sleepData) {
      totalMinutes += details.ActivityValue.toInt();
      totalTimeInBed += details.ActivityTotalTime;
      if (details.ActivityValue > 0) {
        totalCount++;
      }
    }
    if (totalCount == 0) totalCount = 1;
    sleepDetails['deepMin'] = deepMin;
    sleepDetails['lightMin'] = lightMin;
    sleepDetails['remMin'] = remMin;
    sleepDetails['awakeMin'] = awakeMin;
    sleepDetails['totalSleep'] = (totalMinutes) ~/ totalCount;
    sleepDetails['timeInBed'] = totalTimeInBed ~/ totalCount;
    return sleepDetails;
  }

  static int getAge(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;
    if (currentDate.month < dob.month) {
      age--;
    } else if (currentDate.month == dob.month) {
      if (currentDate.day < dob.day) {
        age--;
      }
    }
    return age;
  }

  static List<List<ActivityDetails>> createSublists(
      List<ActivityDetails> myObjects) {
    List<List<ActivityDetails>> sublists = [];
    List<ActivityDetails> currentSublist = [];

    for (int i = 0; i < myObjects.length; i++) {
      ActivityDetails currentObject = myObjects[i];

      // If the current sublist is empty, add the current object to it
      if (currentSublist.isEmpty) {
        currentSublist.add(currentObject);
      } else {
        // Calculate the time difference in hours between the end date of the last object
        // in the current sublist and the start date of the current object
        Duration timeDifference = currentObject.ActivityStartDate.difference(
            currentSublist.last.ActivityEndDate);
        int hoursDifference = timeDifference.inHours;

        // If the time difference is 8 hours or more, start a new sublist
        if (hoursDifference >= 8) {
          sublists.add(List<ActivityDetails>.from(
              currentSublist)); // Add a copy of the current sublist to the list of sublists
          currentSublist.clear(); // Clear the current sublist
        }

        currentSublist.add(
            currentObject); // Add the current object to the current sublist
      }
    }

    // Add the last sublist to the list of sublists
    if (currentSublist.isNotEmpty) {
      sublists.add(currentSublist);
    }

    return sublists;
  }

  static List<ActivitySummary> getSleepSummaryFromDetail(
      List<ActivityDetails> sleepDetails) {
    List<ActivitySummary> summary = [];
    double lightSleep = 0, deepSleep = 0, remSleep = 0, awakeSleep = 0;
    try {
      for (ActivityDetails sleepDetail in sleepDetails) {
        if (sleepDetail.ActivityType == "Sleep") {
          double quality = sleepDetail.ActivityValue;
          DateTime startDate = sleepDetail.ActivityStartDate;
          DateTime endDate = sleepDetail.ActivityEndDate;
          Duration difference = endDate.difference(startDate);
          double differenceInMin = difference.inMilliseconds / 1000 / 60;
          if (quality <= 10) {
            deepSleep += differenceInMin;
          } else if (quality <= 40) {
            lightSleep += differenceInMin;
          } else if (quality <= 99) {
            remSleep += differenceInMin;
          } else if (quality <= 255) {
            awakeSleep += differenceInMin;
          }
        }
      }
      if (lightSleep > 0 || deepSleep > 0) {
        summary.add(ActivitySummary(
            UID: getIt<SharedPreferences>().getString("uid") ?? "",
            ActivityType: "Sleep",
            ActivityDate: sleepDetails.last.ActivityEndDate,
            date: DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(sleepDetails.last.ActivityEndDate),
            ActivityTotalTime:
                (lightSleep + deepSleep + remSleep + awakeSleep).toInt(),
            ActivityValue: lightSleep + deepSleep + remSleep,
            DeviceType:
                getIt<SharedPreferences>().getString("device_name") ?? "",
            IsSynced: false,
            IsGoogleFitSync: false));
      }
    } catch (e) {
      print(e);
    }
    return summary;
  }
}
