import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';

class BaseResponseModel extends BaseResponseEntity{

  BaseResponseModel({status, errorMessage}) : super(status: status, errorMessage: errorMessage);

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}
