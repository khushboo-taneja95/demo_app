import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/join_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/leave_challenges_models.dart';

abstract class JoinChallengeRepository {
  Future<Either<Failure, JoinChallengeModel>> joinChallenges(
      {required String uid, required String challengeId});

  Future<Either<Failure, LeaveChallengesModel>> leaveChallenges(
      {required String challengeId, required String participantUid});
}
