import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/join_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/join_challenges_repository.dart';
import 'package:tres_connect/global_configuration.dart';

class JoinChallengesUseCase {
  final JoinChallengeRepository repository;

  JoinChallengesUseCase({required this.repository});

  Future<Either<Failure, JoinChallengeModel>> call(
      JoinChallengesParams params) {
    return repository.joinChallenges(
      uid: getIt<GlobalConfiguration>().profile.uID ?? "",
      challengeId: params.challengeId,
    );
  }
}

class JoinChallengesParams extends Equatable {
  final String uid;
  final String challengeId;

  const JoinChallengesParams({
    required this.uid,
    required this.challengeId,
  });

  @override
  List<Object?> get props => [
        uid,
        challengeId,
      ];
}
