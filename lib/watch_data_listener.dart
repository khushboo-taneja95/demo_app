import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/core/utility/activity_utils.dart';
import 'package:tres_connect/core/utility/file_utils.dart';

Future<bool> fetchVitalsInBG() async {
  FileUtils.writeLog("Workmanager execution started");
  Completer<bool> complete = Completer();
  SharedPreferences preferences = getIt<SharedPreferences>();
  String uid = preferences.getString("uid") ?? "";
  String? deviceAddress = preferences.getString("device_address");
  String? deviceName = preferences.getString("device_name");
  FileUtils.writeLog("Device address: $deviceAddress Device name: $deviceName");
  if (deviceAddress == null ||
      deviceAddress.isEmpty ||
      deviceName == null ||
      deviceName.isEmpty) {
    debugPrint("Device address is null. Cancelling vitals fetch.");
    complete.complete(true);
    return complete.future;
  }

  return complete.future;
}

Future<void> uploadData() async {}
