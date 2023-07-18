import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';

class UserProfileModel {
  int? status;
  String? errorMessage;
  ProfileInfo? userProfileInfo;

  UserProfileModel({this.status, this.errorMessage, this.userProfileInfo});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    userProfileInfo = json['UserProfileInfo'] != null
        ? ProfileInfo.fromJson(json['UserProfileInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (userProfileInfo != null) {
      data['UserProfileInfo'] = userProfileInfo!.toJson();
    }
    return data;
  }
}

class ProfileInfo extends UserProfileEntiry {
  ProfileInfo(
      {uID,
      firstName,
      lastName,
      emailId,
      gender,
      weight,
      height,
      dateOfBirth,
      profileImage,
      dateCreated,
      lastHealthStatusTime,
      lastHealthRiskValue,
      lastHealthRiskRating,
      cropUserProfilePicture,
      travelStatus,
      travelReason,
      remarks,
      loginSource,
      sourceToken,
      authorizationToken,
      tokenExpiryTime,
      reasonToShow,
      remarksStatusTime,
      medicalAssistance})
      : super(
            uID: uID,
            firstName: firstName,
            lastName: lastName,
            emailId: emailId,
            profileImage: profileImage,
            lastHealthStatusTime: lastHealthStatusTime,
            lastHealthRiskValue: lastHealthRiskValue,
            lastHealthRiskRating: lastHealthRiskRating,
            cropUserProfilePicture: cropUserProfilePicture,
            travelStatus: travelStatus,
            travelReason: travelReason,
            remarks: remarks,
            reasonToShow: reasonToShow,
            remarksStatusTime: remarksStatusTime,
            medicalAssistance: medicalAssistance,
            dateOfBirth: dateOfBirth,
            gender: gender,
            height: height,
            weight: weight,
            dateCreated: dateCreated,
            loginSource: loginSource,
            sourceToken: sourceToken,
            authorizationToken: authorizationToken,
            tokenExpiryTime: tokenExpiryTime);

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    if (json['EmergencyContacts'] != null) {
      emergencyContacts = <EmergencyContacts>[];
      json['EmergencyContacts'].forEach((v) {
        emergencyContacts!.add(EmergencyContacts.fromJson(v));
      });
    }
    gender = json['Gender'];
    weight = json['Weight'];
    height = json['Height'];
    dateOfBirth = json['DateOfBirth'];
    profileImage = json['ProfileImage'];
    dateCreated = json['DateCreated'];
    lastHealthStatusTime = json['LastHealthStatusTime'];
    lastHealthRiskValue = json['LastHealthRiskValue'];
    lastHealthRiskRating = json['LastHealthRiskRating'];
    cropUserProfilePicture = json['CropUserProfilePicture'];
    travelStatus = json['TravelStatus'];
    travelReason = json['TravelReason'];
    remarks = json['Remarks'];
    reasonToShow = json['ReasonToShow'];
    remarksStatusTime = json['RemarksStatusTime'];
    medicalAssistance = json['MedicalAssistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = uID;
    if (emergencyContacts != null) {
      data['EmergencyContacts'] =
          emergencyContacts!.map((v) => v.toJson()).toList();
    }
    data['Gender'] = gender;
    data['Weight'] = weight;
    data['Height'] = height;
    data['DateOfBirth'] = dateOfBirth;
    data['ProfileImage'] = profileImage;
    data['DateCreated'] = dateCreated;
    data['LastHealthStatusTime'] = lastHealthStatusTime;
    data['LastHealthRiskValue'] = lastHealthRiskValue;
    data['LastHealthRiskRating'] = lastHealthRiskRating;
    data['s'] = cropUserProfilePicture;
    data['TravelStatus'] = travelStatus;
    data['TravelReason'] = travelReason;
    data['Remarks'] = remarks;
    data['ReasonToShow'] = reasonToShow;
    data['RemarksStatusTime'] = remarksStatusTime;
    data['MedicalAssistance'] = medicalAssistance;
    return data;
  }
}
