import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/utility/EncodeUtils.dart';
import 'package:tres_connect/features/main/data/models/notifications_model.dart';

abstract class MainRemoteDataSource {
  Future<NotificationModel> getNotifications({required String uid});
  Future<void> updateDeviceType(
      {required String uid, required String deviceType});
}

class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  final Dio dio = getIt<Dio>();

  @override
  Future<NotificationModel> getNotifications({
    required String uid,
  }) async {
    final response = await dio.post(AppUrl.SYNC_NOTIFICATIONS, data: {
      "SynchFromDate": DateUtility.formatDateTime(
          dateTime: DateTime.now().subtract(const Duration(days: 31)),
          outputFormat: "yyyy-MM-dd'T'HH:mm:ss"),
      "UID": EncodeUtils.encodeBase64(uid),
      "OS": Platform.isAndroid ? "Android" : "iOS",
    });
    var baseResponseModel = NotificationModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("${baseResponseModel.errorMessage}");
    }
  }

  @override
  Future<void> updateDeviceType(
      {required String uid, required String deviceType}) async {
    final response = await dio.post(AppUrl.UPDATE_DEVICE_TYPE, data: {
      "UID": EncodeUtils.encodeBase64(uid),
      "DeviceType": deviceType,
    });
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Unable to update device type");
    }
  }
}
