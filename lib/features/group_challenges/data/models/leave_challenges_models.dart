class LeaveChallengesModel {
  int? status;
  String? leaveChallenge;

  LeaveChallengesModel({this.status, this.leaveChallenge});

  LeaveChallengesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    leaveChallenge = json['LeaveChallenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['LeaveChallenge'] = this.leaveChallenge;
    return data;
  }
}
