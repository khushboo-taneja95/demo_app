import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/features/auth/data/datasources/auth_local_data_source.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: AppUrl.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: AppUrl.baseUrl,
      receiveTimeout: const Duration(seconds: 60), // 15 seconds
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));

    if(kDebugMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    dio.interceptors.addAll({
      AppInterceptors(dio),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = AuthLocalDataSourceImpl().getToken();

    if (accessToken != null) {
      var expiryTime = AuthLocalDataSourceImpl().getExpiryTime();
      var expiration = DateTime.now().difference(expiryTime);
      if (expiration.inSeconds < 60) {
        log("AccessToken is expiring in $expiration");
      }

      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
