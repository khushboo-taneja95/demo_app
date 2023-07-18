// import 'dart:io';

// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tres_connect/core/database/database.dart';
// import 'package:tres_connect/core/di/injection.dart';
// import 'package:tres_connect/core/utility/DateUtility.dart';
// import 'dart:convert';

// class Analyse7DaysData {
//   static const int daysCount = 7;
 
//   DateFormat df = DateFormat("yyyy.MM.dd HH:mm:ss");

 
//   Future<String> call() async {
//     try {
//       List<Map<String, Object>> mapList = <Map<String, Object>>[];
//       Map<String, Object> tempMap;
//       var obj = jsonDecode('{}');
//       testReportList = [];
//       testReportListSendTOFlutter = [];
//       antiBodyTestList = [];
//       antigenCertificate14days = [];
//       //hitBroadCast(); boradcast that rating is being analysed
//       DateTime prevoiusCalender;
//       String previousDate;
//       df = DateFormat("dd-MMM-yyyy");
//       for (int i = 6, j = 1, k = 0; i >= 0; i--, j++, k++) {
//         tempMap = <String, Object>{};
//         prevoiusCalender = DateTime.now();
//         prevoiusCalender.add(Duration(days: -i));
//         //prevoiusCalender.add(Calendar.DAY_OF_MONTH, -i);
//         previousDate = df.format(prevoiusCalender);
//         // List<Vital> vital = CareAtWorkDB.obj().getLastSevenDaysBt("BT",
//         //     ApplicationController.getInstance(), previousDate, 37.23, k, false);

//         List<Vital> vitals = [];
//         final vitalsResp = await vitalRepository.fetchVitals(
//             medicalCode: "BT",
//             startDate: DateUtility.toDayStart(prevoiusCalender),
//             endDate: DateUtility.toDayEnd(prevoiusCalender));
//         vitalsResp.fold((l) => null, (r) {
//           r.forEach((element) {
//             vitals.add(Vital.fromEntity(element));
//           });
//         });

//         List<Vital> newMovingAverageLogicList =
//             calculateAveragePointsBT(vitals, "BT");
//         String key = "Day" + j.toString();
//         tempMap[key] = formatTimestamp(newMovingAverageLogicList);
//         mapList.add(tempMap);
//       }
//       var gson1 = jsonEncode(mapList);

//       // vaccinationCertificate14days = CareAtWorkDB.obj()
//       //     .getFourteenDaysTestReport("COD", "Vaccination", false);
//       final certificates = await getIt<AppDatabase>()
//           .vaccinationtTestDao
//           .findAllByDateTypeAndDisease(
//               "COD",
//               "Vaccination",
//               DateTime.now()
//                   .subtract(const Duration(days: daysCount))
//                   .toIso8601String(),
//               DateTime.now().toIso8601String());

//       certificates.forEach((element) {
//         vaccinationCertificate14days
//             .add(VaccinationCertificate14days.fromEntity(element));
//       });

//       final testReports = await getIt<AppDatabase>()
//           .vaccinationtTestDao
//           .findAllByDateTypeAndDisease(
//               "COD",
//               "Test",
//               DateTime.now()
//                   .subtract(const Duration(days: daysCount))
//                   .toIso8601String(),
//               DateTime.now().toIso8601String());
//       testReports.forEach((element) {
//         testReportList.add(VaccinationCertificate14days.fromEntity(element));
//       });

//       for (var model in testReportList) {
//         print(model.vaccinationName?.toUpperCase());
//         if (model.vaccinationName?.toUpperCase() == "PCR" ||
//             model.vaccinationName?.toUpperCase() == "RT-PCR") {
//           testReportListSendTOFlutter.add(model);
//         }
//       }

//       final antibodyList = await getIt<AppDatabase>()
//           .vaccinationtTestDao
//           .findAllByName(
//               "Antibody",
//               DateTime.now()
//                   .subtract(const Duration(days: daysCount))
//                   .toIso8601String(),
//               DateTime.now().toIso8601String());
//       // antiBodyTestList = CareAtWorkDB.obj().getFourteenDaysAntibody("Antibody");

//       antibodyList.forEach((element) {
//         antiBodyTestList.add(VaccinationCertificate14days.fromEntity(element));
//       });

//       final antigenList = await getIt<AppDatabase>()
//           .vaccinationtTestDao
//           .findAllByName(
//               "Antigen",
//               DateTime.now()
//                   .subtract(const Duration(days: daysCount))
//                   .toIso8601String(),
//               DateTime.now().toIso8601String());
// // antigenCertificate14days =
// //         CareAtWorkDB.obj().getFourteenDaysAntibody("Antigen");
//       antigenList.forEach((element) {
//         antigenCertificate14days
//             .add(VaccinationCertificate14days.fromEntity(element));
//       });

//       final vitalsResp = await vitalRepository.fetchVitals(
//           medicalCode: "OS",
//           startDate: DateUtility.toDayStart(DateTime.now()),
//           endDate: DateUtility.toDayEnd(DateTime.now()));
//       vitalsResp.fold((l) => null, (r) {
//         r.forEach((element) {
//           twentyFourHOSlist.add(Vital.fromEntity(element));
//         });
//       });

//       // twentyFourHOSlist = CareAtWorkDB.obj()
//       //     .getTwentyFourOs(ApplicationController.getInstance(), "OS");
//       var newMovingAverageLogicList = calculateAveragePointsOS(
//         twentyFourHOSlist,
//         "OS",
//       );
//       twentyFourHOSlistFs.clear();

//       for (Vital healthReading in newMovingAverageLogicList) {
//         // Vital healthReadingNew = HealthReadingNew(
//         //   healthReading.getReadingMin(),
//         //   healthReading.readingMax,
//         //   healthReading.getSyncStatus(),
//         //   healthReading.getLocLatitude(),
//         //   healthReading.getLocLongitude(),
//         //   healthReading.getMedicalCode(),
//         //   getDate(int.parse(healthReading.getTimeStampStr())),
//         // );
//         twentyFourHOSlistFs.add(healthReading);
//       }

//       twentyFourHOSlistFs = formatTimestamp(twentyFourHOSlistFs);

//       Map<String, dynamic> flutterMap = {};

//       bool isBtForLast24HrAvailable = await checkLast24hrData("BT");
//       bool isOSForLast24HrAvailable = await checkLast24hrData("OS");
//       print("BT: $isBtForLast24HrAvailable");
//       print("OS: $isOSForLast24HrAvailable");

//       String device_address =
//           getIt<SharedPreferences>().getString("device_address") ?? "";
//       bool is24HrDataFound = twentyFourHOSlistFs.isNotEmpty;
//       bool isConnected = false;
//       if (Platform.isAndroid) {
//       } else if (Platform.isIOS) {
//         if (device_address != null) {
//           isConnected = true;
//         } else {
//           isConnected = false;
//         }
//       }

//       if (!is24HrDataFound) {
//         flutterMap["CovidReport14days"] = testReportListSendTOFlutter;
//         flutterMap["ANTIGEN"] = antigenCertificate14days;
//         flutterMap["BodytempFor7days"] = mapList.isNotEmpty ? mapList : [];
//         flutterMap["OSFor24Hour"] =
//             twentyFourHOSlistFs.isNotEmpty ? twentyFourHOSlistFs : [];
//         flutterMap["VaccinationCertificate14days"] =
//             vaccinationCertificate14days;
//         flutterMap["BTForLast24Hr"] = isBtForLast24HrAvailable;
//         flutterMap["OSForLast24Hr"] = isBtForLast24HrAvailable;
//       } else {
//         flutterMap["ANTIGEN"] = antigenCertificate14days;
//         flutterMap["CovidReport14days"] = testReportListSendTOFlutter;
//         flutterMap["BodytempFor7days"] = mapList;
//         flutterMap["OSFor24Hour"] = twentyFourHOSlistFs;
//         flutterMap["VaccinationCertificate14days"] =
//             vaccinationCertificate14days;
//         flutterMap["BTForLast24Hr"] = isBtForLast24HrAvailable;
//         flutterMap["OSForLast24Hr"] = isOSForLast24HrAvailable;
//       }

//       String json = jsonEncode(flutterMap);
//       return json;
//     } catch (e) {
//       print(e);
//       return "";
//     }
//   }

//   List<Vital> formatTimestamp(List<Vital> vitals) {
//     //convert timestamp from milliseconds to yyyy-MM-dd HH:mm:ss
//     List<Vital> formattedVitals = [];
//     vitals.forEach((element) {
//       if (element.timeStamp?.length == 10) {
//         element.timeStamp = element.timeStamp! + "000";
//       }
//       int milliseconds = int.parse(element.timeStamp ?? "0");
//       element.timeStamp = DateUtility.formatDateTime(
//           dateTime: DateTime.fromMillisecondsSinceEpoch(milliseconds),
//           outputFormat: "yyyy-MM-dd HH:mm:ss");
//       formattedVitals.add(element);
//     });
//     return formattedVitals;
//   }

//   Future<bool> checkLast24hrData(String medicalCode) async {
//     DateTime previousDate = DateTime.now().subtract(const Duration(days: 1));
//     DateTime currentDate = DateTime.now();

//     // int startRange, endRange;
//     // DateFormat df2 = DateFormat("dd-MMM-yyyy HH:mm:ss", Locale.defaultLanguage);
//     // previousDate = DateTime.now();
//     // currentDate = previousDate;

//     // endRange = currentDate.millisecondsSinceEpoch;

//     // previousDate = previousDate.subtract(Duration(days: 1));
//     // startRange = previousDate.millisecondsSinceEpoch;
//     bool flag = false;
//     final vitalsResp = await vitalRepository.fetchVitals(
//         medicalCode: "BT",
//         startDate: DateUtility.toDayStart(previousDate),
//         endDate: DateUtility.toDayEnd(currentDate));
//     vitalsResp.fold((l) {
//       flag = false;
//     }, (r) {
//       flag = r.isNotEmpty;
//     });
//     return flag;
//   }

//   List<Vital> calculateAveragePointsOS(List<Vital> osList, String medicalCode) {
//     DateFormat sdf = DateFormat("dd-MMM-yyyy");
//     String previousDate = sdf.format(DateTime.now());
//     int from = 0, to = 0;

//     try {
//       DateTime sdate = sdf.parse(previousDate);
//       DateTime date1 =
//           DateTime(sdate.year, sdate.month, sdate.day, 23, 59, 0, 0, 0);
//       to = date1.millisecondsSinceEpoch;
//     } catch (ParseException) {
//       rethrow;
//     }

//     try {
//       DateTime sdate1 = sdf.parse(previousDate);
//       DateTime date1 =
//           DateTime(sdate1.year, sdate1.month, sdate1.day, 0, 0, 0, 0, 0);
//       from = date1.millisecondsSinceEpoch;
//     } catch (ParseException) {
//       rethrow;
//     }

//     int movingAverageGap = 1;
//     if (osList.length > 2 && osList.length <= 10) {
//       movingAverageGap = 3;
//     } else if (osList.length > 10 && osList.length <= 30) {
//       movingAverageGap = 3;
//     } else {
//       movingAverageGap = 5;
//     }

//     int counter = 0;
//     List<int> timeSetList = [];
//     int positionGap = (movingAverageGap ~/ 2) + 1;
//     int x = (osList.length ~/ positionGap);
//     int counterForPosition = 0;

//     for (int i = 0; i < osList.length; i++) {
//       if (counter == 0) {
//         timeSetList.add(i);
//         counter++;
//       } else {
//         if (x == counter) {
//           break;
//         } else {
//           counterForPosition++;
//           if (counterForPosition == positionGap) {
//             timeSetList.add(i);
//             counter++;
//             counterForPosition = 0;
//           }
//         }
//       }
//     }

//     if (osList.length > 1) {
//       if (timeSetList.length - 1 != osList.length) {
//         timeSetList.add(osList.length - 1);
//       }
//     }

//     List<Vital> averageEntries = [];

//     for (int i = 0; i < timeSetList.length; i++) {
//       int positionForBtList = timeSetList[i];
//       Vital healthReading = osList[positionForBtList];
//       Vital vital = healthReading;

//       int xValue;

//       if (healthReading.timeStamp?.length == 10) {
//         xValue = int.parse(healthReading.timeStamp ?? "0") * 1000;
//       } else {
//         xValue = int.parse(healthReading.timeStamp ?? "0");
//       }

//       double y = healthReading.readingMax ?? 0;

//       if (from <= xValue && to >= xValue) {
//         print("Week: $x == $y");

//         if (i == 0) {
//           int startIndex = timeSetList[i];

//           if (timeSetList.length > 1) {
//             int endIndex = timeSetList[i + 1];

//             double average =
//                 calculateAverageValues(startIndex, endIndex, osList);

//             if (medicalCode.toLowerCase() == "os") {
//               vital.readingMax = average;
//             } else {
//               vital.readingMax = average;
//             }

//             averageEntries.add(vital);
//           } else {
//             averageEntries.add(vital);
//           }
//         } else if (timeSetList.length - 1 == i) {
//           int startIndex = timeSetList[i - 1];
//           int endIndex = timeSetList[i];

//           double average = calculateAverageValues(startIndex, endIndex, osList);

//           if (medicalCode.toLowerCase() == "os") {
//             vital.readingMax = average;
//           } else {
//             vital.readingMax = average;
//           }

//           averageEntries.add(vital);
//         } else {
//           int startIndex = timeSetList[i - 1];
//           int endIndex = timeSetList[i];
//           double average = calculateAverageValues(startIndex, endIndex, osList);
//           startIndex = timeSetList[i];
//           endIndex = timeSetList[i + 1];
//           double average2 =
//               calculateAverageValues(startIndex, endIndex, osList);
//           double finalAverage = (average + average2) / 2;

//           if (medicalCode.toLowerCase() == "os") {
//             vital.readingMax = finalAverage;
//           } else {
//             vital.readingMax = finalAverage;
//           }

//           averageEntries.add(vital);
//         }
//       }
//     }

//     return averageEntries;
//   }

//   List<Vital> calculateAveragePointsBT(List<Vital> osList, String medicalCode) {
//     int movingAverageGap = 1;
//     if (osList.length > 2 && osList.length <= 10) {
//       movingAverageGap = 3;
//     } else if (osList.length > 10 && osList.length <= 30) {
//       movingAverageGap = 3;
//     } else {
//       movingAverageGap = 5;
//     }

//     int counter = 0;
//     List<int> timeSetList = [];
//     int positionGap = (movingAverageGap ~/ 2) + 1;
//     int x = (osList.length ~/ positionGap);
//     int counterForPosition = 0;

//     for (int i = 0; i < osList.length; i++) {
//       if (counter == 0) {
//         timeSetList.add(i);
//         counter++;
//       } else {
//         if (x == counter) {
//           break;
//         } else {
//           counterForPosition++;
//           if (counterForPosition == positionGap) {
//             timeSetList.add(i);
//             counter++;
//             counterForPosition = 0;
//           }
//         }
//       }
//     }

//     if (osList.length > 1) {
//       if (timeSetList.length - 1 != osList.length) {
//         timeSetList.add(osList.length - 1);
//       }
//     }

//     List<Vital> averageEntries = [];

//     for (int i = 0; i < timeSetList.length; i++) {
//       int positionForBtList = timeSetList[i];
//       Vital healthReading = osList[positionForBtList];
//       Vital vital = healthReading;

//       if (i == 0) {
//         if (vital.readingMax! > 37.23) {
//           averageEntries.add(vital);
//         }
//       } else if (timeSetList.length - 1 == i) {
//         int startIndex = timeSetList[i - 1];
//         int endIndex = timeSetList[i];
//         double average = calculateAverageValuesBT(startIndex, endIndex, osList);

//         if (average > 37.23) {
//           vital.readingMax = average;
//           averageEntries.add(vital);
//         }
//       } else {
//         int startIndex = timeSetList[i - 1];
//         int endIndex = timeSetList[i];
//         double average = calculateAverageValuesBT(startIndex, endIndex, osList);
//         startIndex = timeSetList[i];
//         endIndex = timeSetList[i + 1];
//         double average2 =
//             calculateAverageValuesBT(startIndex, endIndex, osList);
//         double finalAverage = (average + average2) / 2;

//         if (finalAverage > 37.23) {
//           vital.readingMax = finalAverage;
//           averageEntries.add(vital);
//         }
//       }
//     }

//     return averageEntries;
//   }

//   double calculateAverageValues(
//       int startIndex, int endIndex, List<Vital> osList) {
//     double averageValues = 0;

//     for (int i = startIndex; i < endIndex; i++) {
//       double value = osList[i].readingMax!;
//       averageValues += value;
//     }

//     int divider = endIndex - startIndex;
//     averageValues = averageValues / divider;

//     return averageValues;
//   }

//   double calculateAverageValuesBT(
//       int startIndex, int endIndex, List<Vital> osList) {
//     double averageValues = 0;

//     for (int i = startIndex; i < endIndex; i++) {
//       double value = osList[i].readingMax!;
//       averageValues += value;
//     }

//     int divider = endIndex - startIndex;
//     averageValues = averageValues / divider;

//     return averageValues;
//   }

//   String getDate(int timeStampServer) {
//     DateTime dateTime =
//         DateTime.fromMillisecondsSinceEpoch(timeStampServer * 1000);
//     DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
//     return formatter.format(dateTime);
//   }
// }
