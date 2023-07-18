import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/get_all_badges_model.dart';
import '../../data/models/get_check_result_model.dart';
import '../../data/models/get_participant_model.dart';
import '../../data/models/like_unlike_model.dart';
import '../../data/models/liked_list_model.dart';

abstract class ParticipantsRepository {
  Future<Either<Failure, List<GetParticipants>>> getParticipants(
      {required String search, required int id, required int pageSize});
  Future<Either<Failure, LikeUnlikeModel>> likeUnlike({
    required String challengeid,
    required String reaction,
    required String reacted_by,
    required String participant_uid,
  });
  Future<Either<Failure, List<ListOfLikesChallenge>>> listOfLikesChallenge(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid});

  Future<Either<Failure, List<GetAllBadgeByUserId>>> getAllBadgeByUserId(
      {required int startIndex,
      required String uid,
      required int pageSize,
      required int challengeid});
  Future<Either<Failure, CheckResult>> checkResult(
      {required int challengeid, required String uid});
}
