import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/join_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/join_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/leave_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/join_challenges_repository.dart';

class JoinChallengeRepositoryImpl extends JoinChallengeRepository {
  final JoinChallengesRemoteDataSource joinChallengesRemoteDataSource =
      JoinChallengesRemoteDataSourceImpl();

  @override
  Future<Either<Failure, JoinChallengeModel>> joinChallenges({
    required String uid,
    required String challengeId,
  }) async {
    try {
      final data = await joinChallengesRemoteDataSource.joinChallenges(
        uid: uid,
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

  @override
  Future<Either<Failure, LeaveChallengesModel>> leaveChallenges({
    required String challengeId,
    required String participantUid,
  }) async {
    try {
      final data = await joinChallengesRemoteDataSource.leaveChallenges(
        challengeId: challengeId,
        participantUid: participantUid,
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
