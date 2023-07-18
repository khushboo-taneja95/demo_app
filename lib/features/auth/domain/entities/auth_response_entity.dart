import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  String? asClientId;
  String? uID;
  String? userDetail;
  String? issued;
  String? expires;
  String? error;
  String? errorDescription;

  AuthResponseEntity(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.asClientId,
      this.userDetail,
      this.uID,
      this.issued,
      this.expires});

  @override
  List<Object?> get props =>
      [accessToken, tokenType, expiresIn, refreshToken, uID, issued, expires];
}
