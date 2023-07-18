class LikeUnlikeModel {
  int? status;
  String? challengeLike;

  LikeUnlikeModel({this.status, this.challengeLike});

  LikeUnlikeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    challengeLike = json['ChallengeLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ChallengeLike'] = this.challengeLike;
    return data;
  }
}
