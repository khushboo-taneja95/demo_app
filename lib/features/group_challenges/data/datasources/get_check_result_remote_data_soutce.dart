import 'package:dio/dio.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/networking/urls.dart';
import '../models/get_check_result_model.dart';

abstract class GetCheckResultRemoteDataSource {
  Future<GetCheckResultModel> checkResult(
      {required String uid, required int challengeid});
}

class GetCheckResultRemoteDataSourceImpl
    extends GetCheckResultRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<GetCheckResultModel> checkResult(
      {required String uid, required int challengeid}) async {
    final response = await dio.post(AppUrl.GETCHECKRESULT,
        data: {
          "uid": uid,
          "challengeid": challengeid,
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: "application/json"));
    final model = GetCheckResultModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
