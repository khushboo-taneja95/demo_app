import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/group_challenge_repository.dart';

class GetChallengesUseCase
    extends UseCase<List<GetChallenges>, GetChallengesParams> {
  final GroupChallengeRepository repository;

  GetChallengesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<GetChallenges>>> call(
      GetChallengesParams params) {
    return repository.getAllChallenges(
        startIndex: params.startIndex.toString(),
        pageSize: params.pageSize.toString(),
        challengeType: params.challengeType,
        period: params.period,
        uid: params.uid);
  }
}

class GetChallengesParams extends Equatable {
  final int startIndex, pageSize;
  final String challengeType;
  final String period;
  final String uid;

  const GetChallengesParams(
      {this.startIndex = 0,
      this.pageSize = 100,
      required this.challengeType,
      this.period = "ONGOING",
      required this.uid});

  @override
  List<Object?> get props => [startIndex, pageSize, challengeType, period, uid];
}
