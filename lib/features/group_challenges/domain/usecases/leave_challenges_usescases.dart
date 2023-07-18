import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/leave_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/join_challenges_repository.dart';
import 'package:tres_connect/global_configuration.dart';

class LeaveChallengesUseCase {
  final JoinChallengeRepository repository;

  LeaveChallengesUseCase({required this.repository});

  Future<Either<Failure, LeaveChallengesModel>> call(
      LeaveChallengesParams params) {
    return repository.leaveChallenges(
      challengeId: params.challengeId,
      participantUid: getIt<GlobalConfiguration>().profile.uID ?? "",
    );
  }
}

class LeaveChallengesParams extends Equatable {
  final String challengeId;
  final String participantUid;

  const LeaveChallengesParams({
    required this.challengeId,
    required this.participantUid,
  });

  @override
  List<Object?> get props => [
        challengeId,
        participantUid,
      ];
}
