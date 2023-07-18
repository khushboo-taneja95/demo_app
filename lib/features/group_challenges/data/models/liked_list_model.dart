class LikedListModel {
  int? status;
  List<ListOfLikesChallenge>? listOfLikesChallenge;

  LikedListModel({this.status, this.listOfLikesChallenge});

  LikedListModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['ListOfLikesChallenge'] != null) {
      listOfLikesChallenge = <ListOfLikesChallenge>[];
      json['ListOfLikesChallenge'].forEach((v) {
        listOfLikesChallenge!.add(new ListOfLikesChallenge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.listOfLikesChallenge != null) {
      data['ListOfLikesChallenge'] =
          this.listOfLikesChallenge!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListOfLikesChallenge {
  String? uid;
  String? name;
  int? challengeid;

  ListOfLikesChallenge({this.uid, this.name, this.challengeid});

  ListOfLikesChallenge.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    challengeid = json['challengeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['challengeid'] = this.challengeid;
    return data;
  }
}
