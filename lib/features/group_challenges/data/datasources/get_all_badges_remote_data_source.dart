import 'package:dio/dio.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/networking/urls.dart';
import '../models/get_all_badges_model.dart';

abstract class GetAllBadgesRemoteDataSource {
  Future<GetAllBadgesModel> getAllBadgeByUserId(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid});
}

class GetAllBadgesRemoteDataSourceImpl extends GetAllBadgesRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<GetAllBadgesModel> getAllBadgeByUserId(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid}) async {
    final response = await dio.post(AppUrl.GETALLBADGES,
        data: {
          "startIndex": startIndex,
          "uid": uid,
          "pageSize": pageSize,
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: "application/json"));
    final model = GetAllBadgesModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
