import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';

abstract class GroupChallengeRepository {
  Future<Either<Failure, List<GetChallenges>>> getAllChallenges(
      {required String startIndex,
      required String pageSize,
      required String challengeType,
      required String period,
      required String uid});
}
