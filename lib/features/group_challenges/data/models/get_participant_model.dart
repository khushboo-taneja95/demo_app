class GetParticipantModel {
  int? status;
  List<GetParticipants>? getParticipants;

  GetParticipantModel({this.status, this.getParticipants});

  GetParticipantModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['GetParticipants'] != null) {
      getParticipants = <GetParticipants>[];
      json['GetParticipants'].forEach((v) {
        getParticipants!.add(new GetParticipants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.getParticipants != null) {
      data['GetParticipants'] =
          this.getParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetParticipants {
  int? challengeId;
  double? targetAchieved;
  int? totalReactionCount;
  String? fullname;
  String? uid;
  bool? is_liked;

  GetParticipants(
      {this.challengeId,
      this.targetAchieved,
      this.totalReactionCount,
      this.fullname,
      this.uid,
      this.is_liked});

  GetParticipants.fromJson(Map<String, dynamic> json) {
    challengeId = json['challenge_id'];
    targetAchieved = json['target_achieved'];
    totalReactionCount = json['total_reaction_count'];
    fullname = json['fullname'];
    uid = json['uid'];
    is_liked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['challenge_id'] = this.challengeId;
    data['target_achieved'] = this.targetAchieved;
    data['total_reaction_count'] = this.totalReactionCount;
    data['fullname'] = this.fullname;
    data['uid'] = this.uid;
    data['is_liked'] = this.is_liked;
    return data;
  }
}
