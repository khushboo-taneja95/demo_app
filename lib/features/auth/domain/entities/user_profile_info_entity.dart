import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "UserProfile")
class UserProfileEntiry {
  @PrimaryKey()
  @ColumnInfo(name: "UID")
  String? uID;
  @ColumnInfo(name: "FirstName")
  String? firstName;
  @ColumnInfo(name: "LastName")
  String? lastName;
  @ColumnInfo(name: "EmailId")
  String? emailId;
  @ColumnInfo(name: "MobileNo")
  String? mobileNo;
  @ignore
  String? imageUrl;
  @ignore
  List<EmergencyContacts>? emergencyContacts;
  @ColumnInfo(name: "Gender")
  String? gender;
  @ColumnInfo(name: "Weight")
  int? weight;
  @ColumnInfo(name: "Height")
  int? height;
  @ColumnInfo(name: "DOB")
  String? dateOfBirth;
  @ColumnInfo(name: "ProfilePhoto")
  String? cropUserProfilePicture;
  @ColumnInfo(name: "LoginSource")
  String? loginSource;
  @ColumnInfo(name: "SourceToken")
  String? sourceToken;
  @ColumnInfo(name: "AuthorizationToken")
  String? authorizationToken;
  @ColumnInfo(name: "TokenExpiryTime")
  String? tokenExpiryTime;
  @ignore
  String? profileImage;
  @ColumnInfo(name: "CreationDate")
  String? dateCreated;
  @ignore
  String? lastHealthStatusTime;
  @ignore
  String? lastHealthRiskValue;
  @ignore
  String? lastHealthRiskRating;

  @ignore
  String? travelStatus;
  @ignore
  String? travelReason;
  @ignore
  String? remarks;
  @ignore
  String? reasonToShow;
  @ignore
  String? remarksStatusTime;
  @ignore
  int? medicalAssistance;

  UserProfileEntiry(
      {this.uID,
      this.emergencyContacts,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.emailId,
      this.gender,
      this.weight,
      this.height,
      this.dateOfBirth,
      this.profileImage,
      this.dateCreated,
      this.lastHealthStatusTime,
      this.lastHealthRiskValue,
      this.lastHealthRiskRating,
      this.cropUserProfilePicture,
      this.travelStatus,
      this.travelReason,
      this.remarks,
      this.reasonToShow,
      this.remarksStatusTime,
      this.medicalAssistance,
      this.loginSource,
      this.sourceToken,
      this.authorizationToken,
      this.tokenExpiryTime});
}

class EmergencyContacts extends Equatable {
  String? contactName;
  String? contactPhone;
  String? relation;

  EmergencyContacts({this.contactName, this.contactPhone, this.relation});

  EmergencyContacts.fromJson(Map<String, dynamic> json) {
    contactName = json['ContactName'];
    contactPhone = json['ContactPhone'];
    relation = json['Relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ContactName'] = contactName;
    data['ContactPhone'] = contactPhone;
    data['Relation'] = relation;
    return data;
  }

  @override
  List<Object?> get props => [contactName, contactPhone, relation];
}
