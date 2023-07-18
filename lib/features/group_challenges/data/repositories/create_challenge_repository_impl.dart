import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/create_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/create_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/data/models/delete_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_my_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/update_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';

class CreateChallengeRepositoryImpl extends CreateChallengeRepository {
  final CreateChallengesRemoteDataSource createChallengesRemoteDataSource =
      CreateChallengesRemoteDataSourceImpl();

  @override
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
  }) async {
    try {
      final data = await createChallengesRemoteDataSource.createChallenges(
        challengeType: challengeType,
        createdBy: createdBy,
        challengeTitle: challengeTitle,
        challengeTarget: challengeTarget,
        challengeStartDate: challengeStartDate,
        challengeEndDate: challengeEndDate,
        challengeDetails: challengeDetails,
        creationDate: creationDate,
        challengeImage: challengeImage,
        group_name: group_name,
        group_uid: group_uid,
        badge_one: badge_one,
        badge_two: badge_two,
        badge_three: badge_three,
        badge_completion: badge_completion,
      );
      if (data.status == 1) {
        return Right(data);
      } else {
        return const Left(ServerFailure("Unknown error"));
      }
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetAllBadge>>> getAllBadge(
      {required String Rank}) async {
    try {
      final data = await createChallengesRemoteDataSource.getAllBadge(
        Rank: Rank,
      );
      if (data.status == 2) {
        return const Left(ServerFailure("No Badge available."));
      } else {
        if (data.getAllBadge!.isEmpty) {
          return const Left(ServerFailure("No Badge available."));
        } else {
          try {
            final getAllBadge = data.getAllBadge!;
            return Right(getAllBadge);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetMyChallenges>>> getMyChallenge(
      {required String uid,
      required String startIndex,
      required String pageSize}) async {
    try {
      final data = await createChallengesRemoteDataSource.getMyChallenge(
        uid: uid,
        startIndex: startIndex,
        pageSize: pageSize,
      );
      if (data.status == 2) {
        return const Left(ServerFailure("No Challenges available."));
      } else {
        if (data.getMyChallenges!.isEmpty) {
          return const Left(ServerFailure("No Challenges available."));
        } else {
          try {
            final getMyChallenges = data.getMyChallenges!;
            return Right(getMyChallenges);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final data = await createChallengesRemoteDataSource.challengeUpdate(
          challengeType: challengeType,
          createdBy: createdBy,
          challengeTitle: challengeTitle,
          challengeTarget: challengeTarget,
          challengeStartDate: challengeStartDate,
          challengeEndDate: challengeEndDate,
          challengeDetails: challengeDetails,
          creationDate: creationDate,
          challengeId: challengeId);
      if (data.status == 1) {
        return Right(data);
      } else {
        return const Left(ServerFailure("Unknown error"));
      }
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteChallengeModels>> deleteChallenges({
    required String challengeId,
  }) async {
    try {
      final data = await createChallengesRemoteDataSource.deleteChallenges(
        challengeId: challengeId,
      );
      if (data.status == 1) {
        return Right(data);
      } else {
        return const Left(ServerFailure("Unknown error"));
      }
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
