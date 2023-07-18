import 'package:dio/dio.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/networking/urls.dart';
import '../models/liked_list_model.dart';

abstract class LikedListRemoteDataSource {
  Future<LikedListModel> listOfLikesChallenge(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid});
}

class LikedListRemoteDataSourceImpl extends LikedListRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<LikedListModel> listOfLikesChallenge(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid}) async {
    final response = await dio.post(AppUrl.GETLIKEDLIST,
        data: {
          "startIndex": startIndex,
          "uid": uid,
          "pageSize": pageSize,
          "challengeid": challengeid,
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: "application/json"));
    final model = LikedListModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
