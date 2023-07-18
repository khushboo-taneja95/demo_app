import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';

abstract class GroupChallengesRemoteDataSource {
  Future<GetChallengesModel> getAllChallenges(
      {required String startIndex,
      required String pageSize,
      required String challengeType,
      required String period,
      required String uid});
}

class GroupChallengesRemoteDataSourceImpl
    extends GroupChallengesRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<GetChallengesModel> getAllChallenges(
      {required String startIndex,
      required String pageSize,
      required String challengeType,
      required String period,
      required String uid}) async {
    final response = await dio.post(AppUrl.getChallengesApi, data: {
      "startIndex": startIndex,
      "pageSize": pageSize,
      "challengeType": challengeType,
      "period": period,
      "uid": uid
    });
    var baseResponseModel = GetChallengesModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
