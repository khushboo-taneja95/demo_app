class GetAllBadgesModel {
  int? status;
  List<GetAllBadgeByUserId>? getAllBadgeByUserId;

  GetAllBadgesModel({this.status, this.getAllBadgeByUserId});

  GetAllBadgesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['GetAllBadgeByUserId'] != null) {
      getAllBadgeByUserId = <GetAllBadgeByUserId>[];
      json['GetAllBadgeByUserId'].forEach((v) {
        getAllBadgeByUserId!.add(new GetAllBadgeByUserId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.getAllBadgeByUserId != null) {
      data['GetAllBadgeByUserId'] =
          this.getAllBadgeByUserId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllBadgeByUserId {
  int? challengeId;
  String? image;
  double? targetAchieved;
  String? challengeTitle;
  int? rank;

  GetAllBadgeByUserId(
      {this.challengeId,
      this.image,
      this.targetAchieved,
      this.challengeTitle,
      this.rank});

  GetAllBadgeByUserId.fromJson(Map<String, dynamic> json) {
    challengeId = json['ChallengeId'];
    image = json['Image'];
    targetAchieved = json['TargetAchieved'];
    challengeTitle = json['ChallengeTitle'];
    rank = json['Rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ChallengeId'] = this.challengeId;
    data['Image'] = this.image;
    data['TargetAchieved'] = this.targetAchieved;
    data['ChallengeTitle'] = this.challengeTitle;
    data['Rank'] = this.rank;
    return data;
  }
}
