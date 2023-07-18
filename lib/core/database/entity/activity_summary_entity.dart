import 'package:floor/floor.dart';

@Entity(tableName: "ActivitySummary", indices: [
  Index(value: ['ActivityDate', 'ActivityType'], unique: true)
])
class ActivitySummary {
  @PrimaryKey(autoGenerate: true)
  int? RowID;
  final String UID;
  final String ActivityType;
  final DateTime ActivityDate;
  final String date;
  final int ActivityTotalTime;
  final double ActivityValue;
  final bool IsAutomatedReading;
  final String DeviceType;
  final bool IsSynced;
  final bool IsGoogleFitSync;

  ActivitySummary(
      {required this.UID,
      required this.ActivityType,
      required this.ActivityDate,
      required this.date,
      this.ActivityTotalTime = 0,
      required this.ActivityValue,
      this.IsAutomatedReading = true,
      required this.DeviceType,
      required this.IsSynced,
      required this.IsGoogleFitSync});

  ActivitySummary copyWith({
    String? UID,
    String? ActivityType,
    String? date,
    DateTime? ActivityDate,
    int? ActivityTotalTime,
    double? ActivityValue,
    bool? IsAutomatedReading,
    String? DeviceType,
    bool? IsSynced,
    bool? IsGoogleFitSync,
  }) {
    return ActivitySummary(
      UID: UID ?? this.UID,
      ActivityType: ActivityType ?? this.ActivityType,
      ActivityDate: ActivityDate ?? this.ActivityDate,
      ActivityTotalTime: ActivityTotalTime ?? this.ActivityTotalTime,
      ActivityValue: ActivityValue ?? this.ActivityValue,
      IsAutomatedReading: IsAutomatedReading ?? this.IsAutomatedReading,
      DeviceType: DeviceType ?? this.DeviceType,
      IsSynced: IsSynced ?? this.IsSynced,
      IsGoogleFitSync: IsGoogleFitSync ?? this.IsGoogleFitSync,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Type": ActivityType,
      "TimeStamp": ActivityDate.toIso8601String(),
      "TotalTime": ActivityTotalTime,
      "Value": ActivityValue,
    };
  }
}
