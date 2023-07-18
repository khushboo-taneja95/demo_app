import 'package:tres_connect/core/database/entity/health_reading_entity.dart';

class VitalsServerResponse {
  int? status;
  String? errorMessage;
  List<HealthReading>? bloodPressure;
  List<HealthReading>? heartRate;
  List<HealthReading>? bodyTemperature;
  List<HealthReading>? oxygen;

  VitalsServerResponse(
      {this.status,
        this.bloodPressure,
        this.heartRate,
        this.bodyTemperature,
        this.oxygen});

  VitalsServerResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['BloodPressure'] != null) {
      bloodPressure = <HealthReading>[];
      json['BloodPressure'].forEach((v) {
        bloodPressure!.add(HealthReading.fromJson(v));
      });
    }
    if (json['HeartRate'] != null) {
      heartRate = <HealthReading>[];
      json['HeartRate'].forEach((v) {
        heartRate!.add(HealthReading.fromJson(v));
      });
    }
    if (json['BodyTemperature'] != null) {
      bodyTemperature = <HealthReading>[];
      json['BodyTemperature'].forEach((v) {
        bodyTemperature!.add(HealthReading.fromJson(v));
      });
    }
    if (json['Oxygen'] != null) {
      oxygen = <HealthReading>[];
      json['Oxygen'].forEach((v) {
        oxygen!.add(HealthReading.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (bloodPressure != null) {
      data['BloodPressure'] =
          bloodPressure!.map((v) => v.toJson()).toList();
    }
    if (heartRate != null) {
      data['HeartRate'] = heartRate!.map((v) => v.toJson()).toList();
    }
    if (bodyTemperature != null) {
      data['BodyTemperature'] =
          bodyTemperature!.map((v) => v.toJson()).toList();
    }
    if (oxygen != null) {
      data['Oxygen'] = oxygen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
