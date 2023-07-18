class JoinChallengeModel {
  int? status;
  String? joinChallenge;

  JoinChallengeModel({this.status, this.joinChallenge});

  JoinChallengeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    joinChallenge = json['JoinChallenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['JoinChallenge'] = this.joinChallenge;
    return data;
  }
}
