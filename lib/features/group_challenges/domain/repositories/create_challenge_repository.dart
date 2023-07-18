import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/create_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/data/models/delete_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_my_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/update_challenges_models.dart';

abstract class CreateChallengeRepository {
  Future<Either<Failure, CreateChallengesModel>> createChallenges({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    required File? challengeImage,
    required String creationDate,
    required String group_name,
    required String group_uid,
    required String badge_one,
    required String badge_two,
    required String? badge_three,
    required String badge_completion,
  });

  Future<Either<Failure, List<GetAllBadge>>> getAllBadge(
      {required String Rank});

  Future<Either<Failure, List<GetMyChallenges>>> getMyChallenge(
      {required String uid,
      required String startIndex,
      required String pageSize});

  Future<Either<Failure, UpdateChallengeModels>> challengeUpdate({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    // required File? challengeImage,
    required String creationDate,
    required String challengeId,
  });

  Future<Either<Failure, DeleteChallengeModels>> deleteChallenges(
      {required String challengeId});
}
