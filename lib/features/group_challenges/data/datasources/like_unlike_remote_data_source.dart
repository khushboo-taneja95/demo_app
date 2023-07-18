import 'package:dio/dio.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/networking/urls.dart';
import '../models/like_unlike_model.dart';

abstract class LikeUnlikeRemoteDataSource {
  Future<LikeUnlikeModel> likeUnlike(
      {required String challengeid,
      required String reaction,
      required String reacted_by,
      required String participant_uid});
}

class LikeUnlikeRemoteDataSourceImpl extends LikeUnlikeRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<LikeUnlikeModel> likeUnlike(
      {required String challengeid,
      required String reaction,
      required String reacted_by,
      required String participant_uid}) async {
    final response = await dio.post(AppUrl.CHALLENGELIKE,
        data: {
          "challengeid": challengeid,
          "reaction": reaction,
          "reacted_by": reacted_by,
          "participant_uid": participant_uid,
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: "application/json"));
    final model = LikeUnlikeModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
