class QRCodeResponse {
  int? status;
  String? qRCodeBase64;
  String? errorMessage;

  QRCodeResponse({this.status, this.qRCodeBase64, this.errorMessage});

  QRCodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    qRCodeBase64 = json['QRCodeBase64'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['QRCodeBase64'] = this.qRCodeBase64;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}
