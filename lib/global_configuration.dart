import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';

class GlobalConfiguration extends Equatable {
  UserProfileEntiry profile = UserProfileEntiry();

  String healthStatusReason = "";
  String healthStatus = "";
  Color healthStatusColor = Colors.green;
  String reason = "";

  DateTime lastSyncTime = DateTime.now();

  String emailId = "";

  String deviceName = "";
  String deviceAddress = "";

  // Setting variables
  String bandFirmwareVersion = "";
  int batterPercentage = 0;
  int temperatureunit = 0;
  int timeunit = 0;
  int imperialunit = 0;
  int wristonUnit = 0;
  int ancsUnit = 0;
  int remindTypeUnit = 0;
  int remindType1Unit = 0;
  int screenBrightness = 0;
  int baseHeartRateUnit = 0;
  int languageUnit = 0;
  int nightModeUnit = 0;
  int socialDistanceUnit = 0;
  int watchFaceStyleUnit = 0;
  //SmartAlaem Data

  //DND Data
  int switch_flag = 0;
  int startHour = 0;
  int startMin = 0;
  int endHour = 0;
  int endMin = 0;
  Map<String, dynamic> dndDic = {};

  //Drink Water Reminder
  int drinkStartHour = 0;
  int drinkStartMin = 0;
  int drinkEndHour = 0;
  int drinkEndMin = 0;
  int drinkIsopen = 0;
  int drinkInterval = 0;
  //Sedenetary Reminder Variable
  int sedentaryStartHour = 0;
  int sedentaryStartMin = 0;
  int sedentaryEndHour = 0;
  int sedentaryEndMin = 0;
  int sedentaryIsopen = 0;
  int sedentaryNoonONOFF = 0;
  int sedentaryWeekRepeat = 0;
  //Menstrual cycle reminder variable
  int cycleDays = 0;
  int menstrualDays = 0;
  int menstrualReminder = 0;
  int ovulationReminder = 0;
  int peakOvulationReminder = 0;
  int endOFFovulationReminder = 0;
  int menstrualStartHr = 0;
  int menstrualStartMn = 0;
  int menstrualPeriod = 0;
  //custom watch face
  int position = 0;
  int abovetime = 0;
  int belowtime = 0;
  int selectedColor = 0;

  //Added by anubhav

  bool isFarenheit = false;

  void initialize() async {
    profile = await getIt<AppDatabase>().userProfileDao.getUserProfile() ??
        UserProfileEntiry();
  }

  @override
  List<Object?> get props => [
        profile,
        healthStatusReason,
        healthStatus,
        healthStatusColor,
        lastSyncTime,
        emailId,
        deviceName,
        deviceAddress,
        bandFirmwareVersion,
        batterPercentage,
        temperatureunit,
        timeunit,
        imperialunit,
        wristonUnit,
        ancsUnit,
        remindTypeUnit,
        remindType1Unit,
        screenBrightness,
        baseHeartRateUnit,
        languageUnit,
        nightModeUnit,
        socialDistanceUnit,
        watchFaceStyleUnit,
        switch_flag,
        startHour,
        startMin,
        endHour,
        endMin,
        dndDic,
        drinkStartHour,
        drinkStartMin,
        drinkEndHour,
        drinkEndMin,
        drinkIsopen,
        drinkInterval,
        sedentaryStartHour,
        sedentaryStartMin,
        sedentaryEndHour,
        sedentaryEndMin,
        sedentaryIsopen,
        sedentaryNoonONOFF,
        sedentaryWeekRepeat,
        cycleDays,
        menstrualDays,
        menstrualReminder,
        ovulationReminder,
        peakOvulationReminder,
        endOFFovulationReminder,
        menstrualStartHr,
        menstrualStartMn,
        menstrualPeriod,
        position,
        abovetime,
        belowtime,
        selectedColor,
      ];
}
