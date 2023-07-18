import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/update_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';

class UpdateChallengesUseCase {
  final CreateChallengeRepository repository;

  UpdateChallengesUseCase({required this.repository});

  Future<Either<Failure, UpdateChallengeModels>> call(
      UpdateChallengesParams params) {
    return repository.challengeUpdate(
      challengeType: params.challengeType,
      createdBy: params.createdBy.toString(),
      challengeTitle: params.challengeTitle,
      challengeTarget: params.challengeTarget.toString(),
      challengeStartDate: params.challengeStartDate.toString(),
      challengeEndDate: params.challengeEndDate.toString(),
      challengeDetails: params.challengeDetails,
      // challengeImage: params.challengeImage,
      creationDate: params.creationDate.toString(),
      challengeId: params.challengeId.toString(),
    );
  }
}

class UpdateChallengesParams extends Equatable {
  final String challengeType;
  final String challengeTitle;
  final String challengeTarget;
  final String createdBy;
  final String challengeStartDate;
  final String challengeEndDate;
  final String challengeDetails;
  // final File? challengeImage;
  final String creationDate;
  final String challengeId;

  const UpdateChallengesParams({
    required this.createdBy,
    required this.challengeType,
    required this.challengeTitle,
    required this.challengeTarget,
    required this.challengeStartDate,
    required this.challengeEndDate,
    required this.challengeDetails,
    // required this.challengeImage,
    required this.creationDate,
    required this.challengeId,
  });

  @override
  List<Object?> get props => [
        challengeType,
        challengeTitle,
        challengeTarget,
        challengeStartDate,
        challengeEndDate,
        challengeDetails,
        // challengeImage,
        creationDate,
        createdBy,
        challengeId
      ];
}
