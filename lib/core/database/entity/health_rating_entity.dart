import 'package:floor/floor.dart';

@Entity(tableName: "HealthRating")
class HealthRatingEntity {
  @PrimaryKey(autoGenerate: true)
  int? HRowId;
  String? userID;
  String? healthRatingTimeStamp;
  String? riskRating;
  String? remarkStatusTime;
  String? reasonToShow;
  int? isRemarkSync;
  String? riskValue;
  String? travelStatus;
  String? travelReason;
  String? remarks;
  String? healthRatingUserLatitude;
  String? healthRatingUserLongitude;
  String? hIsSynced;

  HealthRatingEntity({
    this.HRowId,
    this.userID,
    this.healthRatingTimeStamp,
    this.riskRating,
    this.remarkStatusTime,
    this.reasonToShow,
    this.isRemarkSync,
    this.riskValue,
    this.travelStatus,
    this.travelReason,
    this.remarks,
    this.healthRatingUserLatitude,
    this.healthRatingUserLongitude,
    this.hIsSynced,
  });

  factory HealthRatingEntity.fromJson(Map<String, dynamic> json) {
    return HealthRatingEntity(
      HRowId: json['HRowId'],
      userID: json['UserID'],
      healthRatingTimeStamp: json['HealthRatingTimeStamp'],
      riskRating: json['RiskRating'],
      remarkStatusTime: json['REMARKSTATUSTIME'],
      reasonToShow: json['REASONTOSHOW'],
      isRemarkSync: json['ISREMARSYNC'],
      riskValue: json['RiskValue'],
      travelStatus: json['TravelStatus'],
      travelReason: json['TravelReason'],
      remarks: json['Remarks'],
      healthRatingUserLatitude: json['HealthRatingUserLatitude'],
      healthRatingUserLongitude: json['HealthRatingUserLongitude'],
      hIsSynced: json['HISSYNCED'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'HRowId': HRowId,
      'UserID': userID,
      'HealthRatingTimeStamp': healthRatingTimeStamp,
      'RiskRating': riskRating,
      'REMARKSTATUSTIME': remarkStatusTime,
      'REASONTOSHOW': reasonToShow,
      'ISREMARSYNC': isRemarkSync,
      'RiskValue': riskValue,
      'TravelStatus': travelStatus,
      'TravelReason': travelReason,
      'Remarks': remarks,
      'HealthRatingUserLatitude': healthRatingUserLatitude,
      'HealthRatingUserLongitude': healthRatingUserLongitude,
      'HISSYNCED': hIsSynced,
    };
  }

  //copy with
  HealthRatingEntity copyWith({
    int? HRowId,
    String? userID,
    String? healthRatingTimeStamp,
    String? riskRating,
    String? remarkStatusTime,
    String? reasonToShow,
    int? isRemarkSync,
    String? riskValue,
    String? travelStatus,
    String? travelReason,
    String? remarks,
    String? healthRatingUserLatitude,
    String? healthRatingUserLongitude,
    String? hIsSynced,
  }) {
    return HealthRatingEntity(
      HRowId: HRowId ?? this.HRowId,
      userID: userID ?? this.userID,
      healthRatingTimeStamp:
          healthRatingTimeStamp ?? this.healthRatingTimeStamp,
      riskRating: riskRating ?? this.riskRating,
      remarkStatusTime: remarkStatusTime ?? this.remarkStatusTime,
      reasonToShow: reasonToShow ?? this.reasonToShow,
      isRemarkSync: isRemarkSync ?? this.isRemarkSync,
      riskValue: riskValue ?? this.riskValue,
      travelStatus: travelStatus ?? this.travelStatus,
      travelReason: travelReason ?? this.travelReason,
      remarks: remarks ?? this.remarks,
      healthRatingUserLatitude:
          healthRatingUserLatitude ?? this.healthRatingUserLatitude,
      healthRatingUserLongitude:
          healthRatingUserLongitude ?? this.healthRatingUserLongitude,
      hIsSynced: hIsSynced ?? this.hIsSynced,
    );
  }
}
