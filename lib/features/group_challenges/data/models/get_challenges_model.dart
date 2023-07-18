class GetChallengesModel {
  int? status;
  List<GetChallenges>? getChallenges;

  GetChallengesModel({this.status, this.getChallenges});

  GetChallengesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['GetChallenges'] != null) {
      getChallenges = <GetChallenges>[];
      json['GetChallenges'].forEach((v) {
        getChallenges!.add(new GetChallenges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.getChallenges != null) {
      data['GetChallenges'] =
          this.getChallenges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetChallenges {
  int? id;
  String? challengeType;
  String? createdBy;
  String? challengeTitle;
  String? challengeStartdate;
  String? challengeEnddate;
  double? target;
  int? participants;
  String? challengeDetails;
  String? challengeImage;
  String? creationDate;
  String? lastUpdatedOn;
  bool? isActive;
  String? groupName;
  String? groupUid;
  bool? isJoined;
  String? challengeCounter;
  int? rank;
  double? steps;
  double? calories;
  double? distance;
  List<Badges>? badges;

  GetChallenges(
      {this.id,
      this.challengeType,
      this.createdBy,
      this.challengeTitle,
      this.challengeStartdate,
      this.challengeEnddate,
      this.target,
      this.participants,
      this.challengeDetails,
      this.challengeImage,
      this.creationDate,
      this.lastUpdatedOn,
      this.isActive,
      this.groupName,
      this.groupUid,
      this.isJoined,
      this.challengeCounter,
      this.rank,
      this.steps,
      this.calories,
      this.distance,
      this.badges});

  GetChallenges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challengeType = json['challengeType'];
    createdBy = json['createdBy'];
    challengeTitle = json['challengeTitle'];
    challengeStartdate = json['challengeStartdate'];
    challengeEnddate = json['challengeEnddate'];
    target = json['target'];
    participants = json['Participants'];
    challengeDetails = json['challenge_details'];
    challengeImage = json['challenge_image'];
    creationDate = json['creation_date'];
    lastUpdatedOn = json['last_updated_on'];
    isActive = json['isActive'];
    groupName = json['groupName'];
    groupUid = json['groupUid'];
    isJoined = json['is_joined'];
    challengeCounter = json['challenge_counter'];
    rank = json['rank'];
    steps = json['steps'];
    calories = json['calories'];
    distance = json['distance'];
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(Badges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['challengeType'] = this.challengeType;
    data['createdBy'] = this.createdBy;
    data['challengeTitle'] = this.challengeTitle;
    data['challengeStartdate'] = this.challengeStartdate;
    data['challengeEnddate'] = this.challengeEnddate;
    data['target'] = this.target;
    data['Participants'] = this.participants;
    data['challenge_details'] = this.challengeDetails;
    data['challenge_image'] = this.challengeImage;
    data['creation_date'] = this.creationDate;
    data['last_updated_on'] = this.lastUpdatedOn;
    data['isActive'] = this.isActive;
    data['groupName'] = this.groupName;
    data['groupUid'] = this.groupUid;
    data['is_joined'] = this.isJoined;
    data['challenge_counter'] = this.challengeCounter;
    data['rank'] = this.rank;
    data['steps'] = this.steps;
    data['calories'] = this.calories;
    data['distance'] = this.distance;
    if (badges != null) {
      data['badges'] = badges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Badges {
  int? id;
  String? badgeImage;
  int? rank;
  int? challengeId;

  Badges({this.id, this.badgeImage, this.rank, this.challengeId});

  Badges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    badgeImage = json['badge_image'];
    rank = json['rank'];
    challengeId = json['challenge_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['badge_image'] = badgeImage;
    data['rank'] = rank;
    data['challenge_id'] = challengeId;
    return data;
  }
}
