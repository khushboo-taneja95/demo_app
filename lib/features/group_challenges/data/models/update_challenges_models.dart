class UpdateChallengeModels {
  int? status;
  String? challengeUpdate;

  UpdateChallengeModels({this.status, this.challengeUpdate});

  UpdateChallengeModels.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    challengeUpdate = json['ChallengeUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ChallengeUpdate'] = this.challengeUpdate;
    return data;
  }
}
