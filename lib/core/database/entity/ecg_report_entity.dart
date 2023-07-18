import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: "ECGReport")
class ECGReportEntity {
  @PrimaryKey(autoGenerate: true)
  int? ECGTransId;
  String? uid;
  String? transDate;
  String? transStartTime;
  String? transEndTime;
  String? transDuration;
  int? stressValue;
  int? bodyFatigueValue;
  int? excitationValue;
  int? hrvValue;
  int? lowestHR;
  int? highestHR;
  List<int>? respirationRateValue;
  List<int>? ecgReading;
  String? walkingSpeed;
  String? gain;
  String? deviceLimb;
  String? deviceChest;
  String? deviceName;
  String? deviceVersion;
  String? appVersion;

  ECGReportEntity({
    this.ECGTransId,
    this.uid,
    this.transDate,
    this.transStartTime,
    this.transEndTime,
    this.transDuration,
    this.stressValue,
    this.bodyFatigueValue,
    this.excitationValue,
    this.hrvValue,
    this.lowestHR,
    this.highestHR,
    this.respirationRateValue,
    this.ecgReading,
    this.walkingSpeed,
    this.gain,
    this.deviceLimb,
    this.deviceChest,
    this.deviceName,
    this.deviceVersion,
    this.appVersion,
  });

  factory ECGReportEntity.fromJson(Map<String, dynamic> json) {
    return ECGReportEntity(
      ECGTransId: json['ECGTransId'],
      uid: json['UID'],
      transDate: json['TransDate'],
      transStartTime: json['TransStartTime'],
      transEndTime: json['TransEndTime'],
      transDuration: json['TransDuration'],
      stressValue: json['StressValue'],
      bodyFatigueValue: json['BodyFatigueValue'],
      excitationValue: json['ExcitationValue'],
      hrvValue: json['HRVValue'],
      lowestHR: json['LowestHR'],
      highestHR: json['HighestHR'],
      respirationRateValue: List<int>.from(jsonDecode(json['RespirationRateValue'])),
      ecgReading: List<int>.from(jsonDecode(json['ECGReading'])),
      walkingSpeed: json['WalkingSpeed'],
      gain: json['Gain'],
      deviceLimb: json['DeviceLimb'],
      deviceChest: json['DeviceChest'],
      deviceName: json['DeviceName'],
      deviceVersion: json['DeviceVersion'],
      appVersion: json['AppVersion'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ECGTransId': ECGTransId,
      'UID': uid,
      'TransDate': transDate,
      'TransStartTime': transStartTime,
      'TransEndTime': transEndTime,
      'TransDuration': transDuration,
      'StressValue': stressValue,
      'BodyFatigueValue': bodyFatigueValue,
      'ExcitationValue': excitationValue,
      'HRVValue': hrvValue,
      'LowestHR': lowestHR,
      'HighestHR': highestHR,
      'RespirationRateValue': jsonEncode(respirationRateValue),
      'ECGReading': jsonEncode(ecgReading),
      'WalkingSpeed': walkingSpeed,
      'Gain': gain,
      'DeviceLimb': deviceLimb,
      'DeviceChest': deviceChest,
      'DeviceName': deviceName,
      'DeviceVersion': deviceVersion,
      'AppVersion': appVersion,
    };
  }
}
