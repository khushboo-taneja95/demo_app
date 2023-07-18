// ignore_for_file: non_constant_identifier_names

import 'package:floor/floor.dart';

@Entity(tableName: "ActivityDetails", indices: [
  Index(value: ['ActivityStartDate', 'ActivityType'], unique: true)
])
class ActivityDetails {
  @PrimaryKey(autoGenerate: true)
  int? RowID;
  final String UID;
  final String ActivityType;
  final DateTime ActivityStartDate;
  final DateTime ActivityEndDate;
  final String date;
  final double ActivityValue;
  final bool IsAutomatedReading;
  final int ActivityTotalSleep;
  final String DeviceType;
  final bool IsSynced;
  final bool IsGoogleFitSync;

  ActivityDetails(
      {required this.UID,
      required this.ActivityType,
      required this.ActivityStartDate,
      required this.ActivityEndDate,
      required this.date,
      required this.ActivityValue,
      this.IsAutomatedReading = true,
      this.ActivityTotalSleep = 0,
      required this.DeviceType,
      required this.IsSynced,
      required this.IsGoogleFitSync});

  ActivityDetails copyWith({
    int? RowID,
    String? UID,
    String? ActivityType,
    DateTime? ActivityStartDate,
    DateTime? ActivityEndDate,
    String? date,
    double? ActivityValue,
    bool? IsAutomatedReading,
    int? ActivityTotalSleep,
    String? DeviceType,
    bool? IsSynced,
    bool? IsGoogleFitSync,
  }) {
    return ActivityDetails(
      UID: UID ?? this.UID,
      ActivityType: ActivityType ?? this.ActivityType,
      ActivityStartDate: ActivityStartDate ?? this.ActivityStartDate,
      ActivityEndDate: ActivityEndDate ?? this.ActivityEndDate,
      date: date ?? this.date,
      ActivityValue: ActivityValue ?? this.ActivityValue,
      IsAutomatedReading: IsAutomatedReading ?? this.IsAutomatedReading,
      ActivityTotalSleep: ActivityTotalSleep ?? this.ActivityTotalSleep,
      DeviceType: DeviceType ?? this.DeviceType,
      IsSynced: IsSynced ?? this.IsSynced,
      IsGoogleFitSync: IsGoogleFitSync ?? this.IsGoogleFitSync,
    );
  }

  //to json
  Map<String, dynamic> toJson() => {
        "Type": ActivityType,
        "StartDate": ActivityStartDate.toIso8601String(),
        "EndDate": ActivityEndDate.toIso8601String(),
        "DeviceName": DeviceType,
        "Value": ActivityValue
      };

  @override
  String toString() {
    return 'ActivityDetails{RowID: $RowID, UID: $UID, ActivityType: $ActivityType, ActivityStartDate: $ActivityStartDate, ActivityEndDate: $ActivityEndDate, date: $date, ActivityValue: $ActivityValue, IsAutomatedReading: $IsAutomatedReading, ActivityTotalSleep: $ActivityTotalSleep, DeviceType: $DeviceType, IsSynced: $IsSynced, IsGoogleFitSync: $IsGoogleFitSync}';
  }
}
