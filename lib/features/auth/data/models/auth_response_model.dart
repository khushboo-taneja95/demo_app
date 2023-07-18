import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  AuthResponseModel(
      {accessToken,
      tokenType,
      expiresIn,
      refreshToken,
      asClientId,
      userDetail,
      uID,
      issued,
      expires})
      : super(
            accessToken: accessToken,
            tokenType: tokenType,
            expiresIn: expiresIn,
            refreshToken: refreshToken,
            asClientId: asClientId,
            userDetail: userDetail,
            uID: uID,
            issued: issued,
            expires: expires);

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    asClientId = json['as:client_Id'];
    userDetail = json['userDetail'];
    uID = json['_uid'];
    issued = json['.issued'];
    expires = json['.expires'];
    error = json['error'];
    errorDescription = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['refresh_token'] = refreshToken;
    data['as:client_Id'] = asClientId;
    data['userDetail'] = userDetail;
    data['_uid'] = uID;
    data['.issued'] = issued;
    data['.expires'] = expires;
    return data;
  }
}
