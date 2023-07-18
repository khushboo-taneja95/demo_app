class CreateChallengesModel {
  int? status;
  String? message;
  String? errorMessage;

  CreateChallengesModel({this.status, this.message, this.errorMessage});

  CreateChallengesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}
