import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/delete_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';

class DeleteChallengesUseCase {
  final CreateChallengeRepository repository;

  DeleteChallengesUseCase({required this.repository});

  Future<Either<Failure, DeleteChallengeModels>> call(
      DeleteChallengesParams params) {
    return repository.deleteChallenges(
      challengeId: params.challengeId,
    );
  }
}

class DeleteChallengesParams extends Equatable {
  final String challengeId;

  const DeleteChallengesParams({
    required this.challengeId,
  });

  @override
  List<Object?> get props => [
        challengeId,
      ];
}
