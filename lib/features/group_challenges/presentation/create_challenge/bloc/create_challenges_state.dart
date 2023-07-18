part of 'create_challenges_bloc.dart';

abstract class CreateChallengeState extends Equatable {
  const CreateChallengeState();

  @override
  List<Object?> get props => [];
}

class CreateChallengeInitial extends CreateChallengeState {}

class CreateChallengeLoading extends CreateChallengeState {
  const CreateChallengeLoading();
}

class CreateChallengeItemDeleted extends CreateChallengeState {}

class CreateChallengeLoaded extends CreateChallengeState {
  const CreateChallengeLoaded(
      {required String message, required List createchallenges});

  @override
  List<Object?> get props => [];
}

class GetBadgesLoaded extends CreateChallengeState {
  final List<GetAllBadge> getAllBadge;
  const GetBadgesLoaded({required this.getAllBadge});

  @override
  List<Object?> get props => [getAllBadge];
}

class CreateChallengeError extends CreateChallengeState {
  final String message;
  const CreateChallengeError({required this.message});
  @override
  List<Object> get props => [message];
}

class CreateChallengesLoaded extends CreateChallengeState {
  final File? file;
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

  const CreateChallengesLoaded({
    this.file,
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
        file,
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
