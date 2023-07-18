class GetMyChallengesModels {
  int? status;
  List<GetMyChallenges>? getMyChallenges;

  GetMyChallengesModels({this.status, this.getMyChallenges});

  GetMyChallengesModels.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['GetMyChallenges'] != null) {
      getMyChallenges = <GetMyChallenges>[];
      json['GetMyChallenges'].forEach((v) {
        getMyChallenges!.add(new GetMyChallenges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.getMyChallenges != null) {
      data['GetMyChallenges'] =
          this.getMyChallenges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetMyChallenges {
  double? steps;
  double? calories;
  double? distance;
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
  Null? challengeCounter;
  List<Badges>? badges;

  GetMyChallenges(
      {this.steps,
      this.calories,
      this.distance,
      this.id,
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
      this.badges});

  GetMyChallenges.fromJson(Map<String, dynamic> json) {
    steps = json['steps'];
    calories = json['calories'];
    distance = json['distance'];
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
    if (json['badges'] != null) {
      badges = <Badges>[];
      json['badges'].forEach((v) {
        badges!.add(new Badges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['steps'] = this.steps;
    data['calories'] = this.calories;
    data['distance'] = this.distance;
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
    if (this.badges != null) {
      data['badges'] = this.badges!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['badge_image'] = this.badgeImage;
    data['rank'] = this.rank;
    data['challenge_id'] = this.challengeId;
    return data;
  }
}
