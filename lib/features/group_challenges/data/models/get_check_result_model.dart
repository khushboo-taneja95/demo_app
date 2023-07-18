class GetCheckResultModel {
  int? status;
  CheckResult? checkResult;

  GetCheckResultModel({this.status, this.checkResult});

  GetCheckResultModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    checkResult = json['CheckResult'] != null
        ? new CheckResult.fromJson(json['CheckResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.checkResult != null) {
      data['CheckResult'] = this.checkResult!.toJson();
    }
    return data;
  }
}

class CheckResult {
  int? id;
  String? challengeType;
  String? createdBy;
  String? challengeTitle;
  String? challengeEnddate;
  int? participants;
  String? badgeImage;
  int? rank;
  String? reactionType;
  double? targetAchieved;
  String? challengeTarget;

  CheckResult(
      {this.id,
      this.challengeType,
      this.createdBy,
      this.challengeTitle,
      this.challengeEnddate,
      this.participants,
      this.badgeImage,
      this.rank,
      this.reactionType,
      this.targetAchieved,
      this.challengeTarget});

  CheckResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challengeType = json['challengeType'];
    createdBy = json['createdBy'];
    challengeTitle = json['challengeTitle'];
    challengeEnddate = json['challengeEnddate'];
    participants = json['Participants'];
    badgeImage = json['BadgeImage'];
    rank = json['Rank'];
    reactionType = json['ReactionType'];
    targetAchieved = json['TargetAchieved'];
    challengeTarget = json['ChallengeTarget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['challengeType'] = this.challengeType;
    data['createdBy'] = this.createdBy;
    data['challengeTitle'] = this.challengeTitle;
    data['challengeEnddate'] = this.challengeEnddate;
    data['Participants'] = this.participants;
    data['BadgeImage'] = this.badgeImage;
    data['Rank'] = this.rank;
    data['ReactionType'] = this.reactionType;
    data['TargetAchieved'] = this.targetAchieved;
    data['ChallengeTarget'] = this.challengeTarget;
    return data;
  }
}
