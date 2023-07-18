import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/core/utility/EncodeUtils.dart';
import 'package:tres_connect/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tres_connect/features/auth/data/models/auth_response_model.dart';
import 'package:tres_connect/features/auth/data/models/base_repponse.dart';
import 'package:tres_connect/features/auth/data/models/qr_code_response.dart';
import 'package:tres_connect/features/auth/data/models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> loginViaEmail(
      {required String email,
      required String password,
      required String name,
      required String source,
      required String token,
      required String clientId,
      required String clientSecret,
      required String grantType});
  Future<BaseResponseModel> register(
      {required String name,
      required String email,
      required String password,
      required String source});
  Future<BaseResponseModel> forgotPassword({required String email});

  Future<BaseResponseModel> mobileNumberVerification(
      {required String mobileno});

  Future<BaseResponseModel> updateUserName(
      {required String uid,
      required String username,
      required String mobileno});

  Future<AuthResponseModel> refreshToken();
  Future<UserProfileModel> getUserProfile(String uID);
  Future<BaseResponseModel> updateUserProfile(Map<String, dynamic> data);
  Future<BaseResponseModel> addUserProfile(Map<String, dynamic> data);
  Future<QRCodeResponse> getQRCode({required String name, required String uid});
  // Future<VitalsServerResponse> getVitalsFromServer(
  //     String uid, DateTime startDate, DateTime endDate, String vitalCode);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio = getIt<Dio>();
  @override
  Future<AuthResponseModel> loginViaEmail(
      {required String email,
      required String password,
      required String name,
      required String source,
      required String token,
      required String clientId,
      required String clientSecret,
      required String grantType}) async {
    final response = await dio.post(AppUrl.LOGIN,
        data: {
          "UserName": EncodeUtils.encodeBase64(email),
          "password": EncodeUtils.encodeBase64(password),
          "fullname": EncodeUtils.encodeBase64(name),
          "source": EncodeUtils.encodeBase64(source),
          "client_id": clientId,
          "client_secret": clientSecret,
          "grant_type": grantType
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.formUrlEncodedContentType));
    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(response.data);
    } else {
      throw Exception(response.data['error_description'] ?? "Unknown Error");
    }
  }

  @override
  Future<BaseResponseModel> register(
      {required String name,
      required String email,
      required String password,
      required String source}) async {
    final response = await dio.post(AppUrl.SIGN_UP,
        data: {
          "EmailId": EncodeUtils.encodeBase64(email),
          "Password": EncodeUtils.encodeBase64(password),
          "FullName": EncodeUtils.encodeBase64(name)
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.formUrlEncodedContentType));
    var baseResponseModel = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("${baseResponseModel.errorMessage}");
    }
  }

  @override
  Future<BaseResponseModel> forgotPassword({
    required String email,
  }) async {
    final response = await dio.post(AppUrl.FORGOT_PASSWORD,
        data: {
          "Emailid": EncodeUtils.encodeBase64(email),
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.formUrlEncodedContentType));
    var baseResponseModel = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("${baseResponseModel.errorMessage}");
    }
  }

  @override
  Future<AuthResponseModel> refreshToken() {
    throw UnimplementedError();
  }

  @override
  Future<UserProfileModel> getUserProfile(String uID) async {
    final response = await dio.post(AppUrl.GET_USER_PROFILE,
        data: {
          "UID": uID,
        },
        options: Options(headers: {
          "Authorization": 'Bearer ${AuthLocalDataSourceImpl().getToken()}'
        }, contentType: Headers.formUrlEncodedContentType));
    var model = UserProfileModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return model;
    } else {
      throw Exception("${model.errorMessage}");
    }
  }

  @override
  Future<BaseResponseModel> updateUserProfile(Map<String, dynamic> data) async {
    final response = await dio.post(AppUrl.UPDATE_PROFILE,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType));
    var model = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return model;
    } else {
      throw Exception("${model.errorMessage}");
    }
  }

  @override
  Future<BaseResponseModel> mobileNumberVerification(
      {required String mobileno}) async {
    final response = await dio.post(AppUrl.MOBILE_VALIDATION,
        data: {
          "MobileNo": EncodeUtils.encodeBase64(mobileno),
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.formUrlEncodedContentType));
    var baseResponseModel = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("${baseResponseModel.errorMessage}");
    }
  }

  @override
  Future<BaseResponseModel> updateUserName(
      {required String uid,
      required String username,
      required String mobileno}) async {
    final response = await dio.post(AppUrl.UPDATE_USER_NAME,
        data: {
          "UID": uid,
          "Fullname": EncodeUtils.encodeBase64(username),
          "MobileNo": EncodeUtils.encodeBase64(mobileno),
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.formUrlEncodedContentType));
    var baseResponseModel = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("${baseResponseModel.errorMessage}");
    }
  }

  @override
  Future<BaseResponseModel> addUserProfile(Map<String, dynamic> data) async {
    final response = await dio.post(AppUrl.ADD_USER_PROFILE,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType));
    var model = BaseResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return model;
    } else {
      throw Exception("${model.errorMessage}");
    }
  }

  @override
  Future<QRCodeResponse> getQRCode(
      {required String name, required String uid}) async {
    final response =
        await dio.post(AppUrl.QR_CODE, data: {"FullName": name, "UID": uid});
    final responseModel = QRCodeResponse.fromJson(response.data);
    if (response.statusCode == 200 && responseModel.status == 1) {
      return QRCodeResponse.fromJson(response.data);
    } else {
      throw Exception("${responseModel.errorMessage}");
    }
  }

  // @override
  // Future<VitalsServerResponse> getVitalsFromServer(String uid,
  //     DateTime startDate, DateTime endDate, String vitalCode) async {
  //   final response = await dio.post(AppUrl.GRAPH_OF_FRIENDS,
  //       data: {
  //         "UID": uid,
  //         "Fromdate": DateUtility.formatDateTime(
  //             dateTime: startDate, outputFormat: "E MMMdd yyyy hh:mm:ss"),
  //         "Todate": DateUtility.formatDateTime(
  //             dateTime: endDate, outputFormat: "E MMMdd yyyy hh:mm:ss"),
  //         "VitalCode": vitalCode
  //       },
  //       options: Options(contentType: Headers.formUrlEncodedContentType));
  //   var model = VitalsServerResponse.fromJson(response.data);
  //   if (response.statusCode == 200) {
  //     return model;
  //   } else {
  //     throw Exception("${model.errorMessage}");
  //   }
  // }
}
