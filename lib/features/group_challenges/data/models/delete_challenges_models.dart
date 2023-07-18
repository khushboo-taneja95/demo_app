class DeleteChallengeModels {
  int? status;
  String? deleteChallenge;

  DeleteChallengeModels({this.status, this.deleteChallenge});

  DeleteChallengeModels.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    deleteChallenge = json['DeleteChallenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['DeleteChallenge'] = this.deleteChallenge;
    return data;
  }
}
