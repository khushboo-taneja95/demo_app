import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/create_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/get_liked_list_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/get_participants_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/like_unlike_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/create_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_participant_model.dart';
import 'package:tres_connect/features/group_challenges/data/models/like_unlike_model.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/get_participant_repository.dart';

import '../datasources/get_all_badges_remote_data_source.dart';
import '../datasources/get_check_result_remote_data_soutce.dart';
import '../models/get_all_badges_model.dart';
import '../models/get_check_result_model.dart';
import '../models/liked_list_model.dart';

class ParticipantsRepositoryImpl extends ParticipantsRepository {
  final ParticipantsRemoteDataSource groupChallengesRemoteDataSource =
      ParticipantsRemoteDataSourceImpl();
  final LikeUnlikeRemoteDataSource likeUnlikeRemoteDataSource =
      LikeUnlikeRemoteDataSourceImpl();
  final LikedListRemoteDataSource likeedlistRemoteDataSource =
      LikedListRemoteDataSourceImpl();
  final GetAllBadgesRemoteDataSource getAllBadgesRemoteDataSource =
      GetAllBadgesRemoteDataSourceImpl();
  final GetCheckResultRemoteDataSource getCheckResultRemoteDataSource =
      GetCheckResultRemoteDataSourceImpl();
//Get participants
  @override
  Future<Either<Failure, List<GetParticipants>>> getParticipants(
      {required String search, required int id, required int pageSize}) async {
    try {
      final data = await groupChallengesRemoteDataSource.getParticipants(
          Id: id.toString(), Search: search, pageSize: pageSize.toString());
      if (data.status == 2) {
        return const Left(ServerFailure("No Challenges available."));
      } else {
        if (data.getParticipants!.isEmpty) {
          return const Left(ServerFailure("No Challenges available."));
        } else {
          try {
            final getChallenges = data.getParticipants!;
            return Right(getChallenges);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

//Like unlike
  @override
  Future<Either<Failure, LikeUnlikeModel>> likeUnlike(
      {required String challengeid,
      required String reaction,
      required String reacted_by,
      required String participant_uid}) async {
    try {
      final data = await likeUnlikeRemoteDataSource.likeUnlike(
          challengeid: challengeid,
          reaction: reaction,
          reacted_by: reacted_by,
          participant_uid: participant_uid);
      if (data.status == 1) {
        return Right(data);
      } else {
        return const Left(ServerFailure("Unknown error"));
      }
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
  /*
  final int startIndex;
  final int pageSize;
  final String uid;
  final int challengeid;
  */

//list of liked
  @override
  Future<Either<Failure, List<ListOfLikesChallenge>>> listOfLikesChallenge(
      {required int startIndex,
      required int pageSize,
      required String uid,
      required int challengeid}) async {
    try {
      final data = await likeedlistRemoteDataSource.listOfLikesChallenge(
          uid: uid,
          pageSize: pageSize,
          startIndex: startIndex,
          challengeid: challengeid);
      if (data.status == 2) {
        return const Left(ServerFailure("No Likes available."));
      } else {
        if (data.listOfLikesChallenge!.isEmpty) {
          return const Left(ServerFailure("No Likes available."));
        } else {
          try {
            final getChallenges = data.listOfLikesChallenge!;
            return Right(getChallenges);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  //Get all badges
  @override
  Future<Either<Failure, List<GetAllBadgeByUserId>>> getAllBadgeByUserId(
      {required int startIndex,
      required int pageSize,
      required String uid,
      required int challengeid}) async {
    try {
      final data = await getAllBadgesRemoteDataSource.getAllBadgeByUserId(
          uid: uid,
          pageSize: pageSize,
          startIndex: startIndex,
          challengeid: challengeid);
      if (data.status == 2) {
        return const Left(ServerFailure("No Likes available."));
      } else {
        if (data.getAllBadgeByUserId!.isEmpty) {
          return const Left(ServerFailure("No Likes available."));
        } else {
          try {
            final getChallenges = data.getAllBadgeByUserId!;
            return Right(getChallenges);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  //Get Check Result
  @override
  Future<Either<Failure, CheckResult>> checkResult(
      {required String uid, required int challengeid}) async {
    try {
      final data = await getCheckResultRemoteDataSource.checkResult(
          uid: uid, challengeid: challengeid);
      if (data.status == 2) {
        return const Left(ServerFailure("No Likes available."));
      } else {
        if (data.checkResult == null || data.checkResult!.id == 0) {
          return const Left(ServerFailure("No Likes available."));
        } else {
          try {
            final getChallenges = data.checkResult!;
            return Right(getChallenges);
          } on Exception catch (e) {
            return Left(AppException(e.toString()));
          }
        }
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
