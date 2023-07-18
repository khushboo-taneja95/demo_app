import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/create_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';

class CreateChallengesUseCase {
  final CreateChallengeRepository repository;

  CreateChallengesUseCase({required this.repository});

  Future<Either<Failure, CreateChallengesModel>> call(
      CreateChallengesParams params) {
    return repository.createChallenges(
      challengeType: params.challengeType,
      createdBy: params.createdBy.toString(),
      challengeTitle: params.challengeTitle,
      challengeTarget: params.challengeTarget.toString(),
      challengeStartDate: params.challengeStartDate.toString(),
      challengeEndDate: params.challengeEndDate.toString(),
      challengeDetails: params.challengeDetails,
      challengeImage: params.challengeImage,
      creationDate: params.creationDate.toString(),
      group_name: params.group_name.toString(),
      badge_completion: params.badge_completion.toString(),
      badge_one: params.badge_one.toString(),
      badge_three: params.badge_three.toString(),
      badge_two: params.badge_two.toString(),
      group_uid: params.group_uid.toString(),
    );
  }
}

class CreateChallengesParams extends Equatable {
  final String challengeType;
  final String challengeTitle;
  final String challengeTarget;
  final String createdBy;
  final String challengeStartDate;
  final String challengeEndDate;
  final String challengeDetails;
  final File? challengeImage;
  final String creationDate;
  final String group_name;
  final String group_uid;
  final String badge_one;
  final String badge_two;
  final String badge_three;
  final String badge_completion;

  const CreateChallengesParams({
    required this.createdBy,
    required this.challengeType,
    required this.challengeTitle,
    required this.challengeTarget,
    required this.challengeStartDate,
    required this.challengeEndDate,
    required this.challengeDetails,
    required this.challengeImage,
    required this.creationDate,
    required this.group_name,
    required this.group_uid,
    required this.badge_one,
    required this.badge_two,
    required this.badge_three,
    required this.badge_completion,
  });

  @override
  List<Object?> get props => [
        challengeType,
        challengeTitle,
        challengeTarget,
        challengeStartDate,
        challengeEndDate,
        challengeDetails,
        challengeImage,
        creationDate,
        createdBy,
        group_name,
        group_uid,
        badge_one,
        badge_two,
        badge_three,
        badge_completion,
      ];
}
