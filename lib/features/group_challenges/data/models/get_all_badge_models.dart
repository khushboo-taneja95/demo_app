class GetAllBadgeModel {
  int? status;
  List<GetAllBadge>? getAllBadge;

  GetAllBadgeModel({this.status, this.getAllBadge});

  GetAllBadgeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['GetAllBadge'] != null) {
      getAllBadge = <GetAllBadge>[];
      json['GetAllBadge'].forEach((v) {
        getAllBadge!.add(new GetAllBadge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.getAllBadge != null) {
      data['GetAllBadge'] = this.getAllBadge!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllBadge {
  int? id;
  int? rank;
  String? image;
  int? active;

  GetAllBadge({this.id, this.rank, this.image, this.active});

  GetAllBadge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['Rank'];
    image = json['image'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Rank'] = this.rank;
    data['image'] = this.image;
    data['active'] = this.active;
    return data;
  }
}
