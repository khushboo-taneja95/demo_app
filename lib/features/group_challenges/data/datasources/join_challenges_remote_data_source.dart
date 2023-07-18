import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/features/group_challenges/data/models/join_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/leave_challenges_models.dart';

abstract class JoinChallengesRemoteDataSource {
  Future<JoinChallengeModel> joinChallenges(
      {required String uid, required String challengeId});
  Future<LeaveChallengesModel> leaveChallenges(
      {required String challengeId, required String participantUid});
}

class JoinChallengesRemoteDataSourceImpl
    extends JoinChallengesRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<JoinChallengeModel> joinChallenges({
    required String uid,
    required String challengeId,
  }) async {
    final response = await dio.post(
      AppUrl.joinChallenges,
      data: {
        "uid": uid,
        "challengeId": challengeId,
      },
    );
    final model = JoinChallengeModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }

  @override
  Future<LeaveChallengesModel> leaveChallenges({
    required String challengeId,
    required String participantUid,
  }) async {
    final response = await dio.post(
      AppUrl.leaveChallenges,
      data: {
        "challengeId": challengeId,
        "participantUid": participantUid,
      },
    );
    final model = LeaveChallengesModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
