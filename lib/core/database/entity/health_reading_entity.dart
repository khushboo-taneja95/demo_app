// ignore_for_file: non_constant_identifier_names
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';

@Entity(tableName: "HealthReadings", indices: [
  Index(value: ['MedicalCode', 'TimeStamp'], unique: true)
])
class HealthReading {
  @PrimaryKey(autoGenerate: true)
  int? RowID;
  String UID;
  DateTime TimeStamp;
  String MedicalCode;
  double ReadingMin;
  double ReadingMax;
  double LocLatitude;
  double LocLongitude;
  String? Date;
  bool IsAutomatedReading;
  bool IsSynced;
  String DeviceType;
  bool IsGoogleFitSync;

  HealthReading(
      {required this.UID,
      required this.TimeStamp,
      required this.MedicalCode,
      this.ReadingMin = 0,
      this.ReadingMax = 0,
      this.LocLatitude = 0,
      this.LocLongitude = 0,
      this.Date,
      required this.IsAutomatedReading,
      required this.IsSynced,
      required this.DeviceType,
      this.IsGoogleFitSync = false});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = UID;
    data['TimeStamp'] = DateUtility.formatDateTime(
        dateTime: TimeStamp.toUtc(),
        outputFormat:
            "yyyy-MM-ddTHH:mm:ss"); //server expects the date in UTC format. So converting to UTC
    data['MedicalCode'] = MedicalCode;
    data['ReadingMin'] = ReadingMin;
    data['ReadingMax'] = ReadingMax;
    data['LocLatitude'] = LocLatitude;
    data['LocLongitude'] = LocLongitude;
    //data['Date'] = Date;
    data['IsAutomatedReading'] = IsAutomatedReading ? "1" : "0";
    //data['IsSynced'] = IsSynced;
    data['DeviceType'] = DeviceType;
    //data['IsGoogleFitSync'] = IsGoogleFitSync;
    return data;
  }

  factory HealthReading.fromJson(Map<String, dynamic> json) {
    //2022-05-10T11:52:00
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
        .parse(json['TimeStamp'], true)
        .toLocal();
    return HealthReading(
        UID: json['UID'],
        TimeStamp: dateTime, //convert to local and save
        MedicalCode: json['MedicalCode'],
        ReadingMin: json['ReadingMin'],
        ReadingMax: json['ReadingMax'],
        LocLatitude: json['LocLatitude'],
        LocLongitude: json['LocLongitude'],
        Date: DateUtility.formatDateTime(
            dateTime: dateTime,
            outputFormat: "yyyy-MM-ddTHH:mm:ss"), //convert to local and save
        IsAutomatedReading: json['IsAutomatedReading'] ?? true,
        IsSynced: json['IsSynced'] ?? true,
        DeviceType: json['DeviceType'] ?? "",
        IsGoogleFitSync: json['IsGoogleFitSync'] ?? false);
  }
}
