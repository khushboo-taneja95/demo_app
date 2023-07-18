class DialMarketResponse {
  int? errorCode;
  String? errorMsg;
  List<Data>? data;

  DialMarketResponse({this.errorCode, this.errorMsg, this.data});

  DialMarketResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? dialNum;
  String? type;
  String? lcd;
  String? toolVersion;
  String? binUrl;
  int? binVersion;
  String? imgUrl;
  String? deviceImgUrl;
  String? customer;
  String? name;
  int? downloadCount;
  String? creatorId;
  String? createTime;
  String? previewImgUrl;
  int? hasComponent;
  Null? componentsRaw;
  Null? relatedProject;
  List<Components>? components;
  int? binSize;

  Data(
      {this.id,
      this.dialNum,
      this.type,
      this.lcd,
      this.toolVersion,
      this.binUrl,
      this.binVersion,
      this.imgUrl,
      this.deviceImgUrl,
      this.customer,
      this.name,
      this.downloadCount,
      this.creatorId,
      this.createTime,
      this.previewImgUrl,
      this.hasComponent,
      this.componentsRaw,
      this.relatedProject,
      this.components,
      this.binSize});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dialNum = json['dialNum'];
    type = json['type'];
    lcd = json['lcd'];
    toolVersion = json['toolVersion'];
    binUrl = json['binUrl'];
    binVersion = json['binVersion'];
    imgUrl = json['imgUrl'];
    deviceImgUrl = json['deviceImgUrl'];
    customer = json['customer'];
    name = json['name'];
    downloadCount = json['downloadCount'];
    creatorId = json['creatorId'];
    createTime = json['createTime'];
    previewImgUrl = json['previewImgUrl'];
    hasComponent = json['hasComponent'];
    componentsRaw = json['componentsRaw'];
    relatedProject = json['relatedProject'];
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
    binSize = json['binSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dialNum'] = this.dialNum;
    data['type'] = this.type;
    data['lcd'] = this.lcd;
    data['toolVersion'] = this.toolVersion;
    data['binUrl'] = this.binUrl;
    data['binVersion'] = this.binVersion;
    data['imgUrl'] = this.imgUrl;
    data['deviceImgUrl'] = this.deviceImgUrl;
    data['customer'] = this.customer;
    data['name'] = this.name;
    data['downloadCount'] = this.downloadCount;
    data['creatorId'] = this.creatorId;
    data['createTime'] = this.createTime;
    data['previewImgUrl'] = this.previewImgUrl;
    data['hasComponent'] = this.hasComponent;
    data['componentsRaw'] = this.componentsRaw;
    data['relatedProject'] = this.relatedProject;
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
    data['binSize'] = this.binSize;
    return data;
  }
}

class Components {
  List<String>? urls;
  int? count;
  int? width;
  int? enable;
  int? height;
  int? positionX;
  int? positionY;

  Components(
      {this.urls,
      this.count,
      this.width,
      this.enable,
      this.height,
      this.positionX,
      this.positionY});

  Components.fromJson(Map<String, dynamic> json) {
    urls = json['urls'].cast<String>();
    count = json['count'];
    width = json['width'];
    enable = json['enable'];
    height = json['height'];
    positionX = json['positionX'];
    positionY = json['positionY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urls'] = this.urls;
    data['count'] = this.count;
    data['width'] = this.width;
    data['enable'] = this.enable;
    data['height'] = this.height;
    data['positionX'] = this.positionX;
    data['positionY'] = this.positionY;
    return data;
  }
}
