import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_my_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';
import 'package:tres_connect/global_configuration.dart';

class GetMyChallengesUseCase
    extends UseCase<List<GetMyChallenges>, GetMyChallengesParams> {
  final CreateChallengeRepository repository;

  GetMyChallengesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<GetMyChallenges>>> call(
      GetMyChallengesParams params) {
    return repository.getMyChallenge(
        uid: getIt<GlobalConfiguration>().profile.uID ?? "",
        startIndex: params.startIndex.toString(),
        pageSize: params.pageSize.toString());
  }
}

class GetMyChallengesParams extends Equatable {
  final int startIndex, pageSize;
  final String uid;
  const GetMyChallengesParams(
    this.uid, {
    this.startIndex = 0,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [
        startIndex,
        pageSize,
        uid,
      ];
}
