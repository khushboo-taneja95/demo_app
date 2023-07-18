import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/group_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/group_challenge_repository.dart';

class GroupChallengeRepositoryImpl extends GroupChallengeRepository {
  final GroupChallengesRemoteDataSource groupChallengesRemoteDataSource =
      GroupChallengesRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<GetChallenges>>> getAllChallenges(
      {required String startIndex,
      required String pageSize,
      required String challengeType,
      required String period,
      required String uid}) async {
    try {
      final data = await groupChallengesRemoteDataSource.getAllChallenges(
          startIndex: startIndex,
          pageSize: pageSize,
          challengeType: challengeType,
          period: period,
          uid: uid);
      if (data.status == 2) {
        return const Left(ServerFailure("No Challenges available."));
      } else {
        if (data.getChallenges!.isEmpty) {
          return const Left(ServerFailure("No Challenges available."));
        } else {
          try {
            final getChallenges = data.getChallenges!;
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
