part of 'create_challenges_bloc.dart';

abstract class CreateChallengeEvent extends Equatable {
  const CreateChallengeEvent();

  @override
  List<Object> get props => [];
}

class CreateChallengeList extends CreateChallengeEvent {}

class LoadCreateChallenge extends CreateChallengeEvent {
  final bool fromRemote;
  const LoadCreateChallenge({this.fromRemote = false});
  List<Object> get props => [];
}

class CreateChallengeLoadEvent extends CreateChallengeEvent {
  final int forRank;
  const CreateChallengeLoadEvent({required this.forRank});

  @override
  List<Object> get props => [forRank];
}

class CreateChallengeEventRating extends CreateChallengeEvent {
  final bool forceRefresh;
  const CreateChallengeEventRating({this.forceRefresh = false});
  @override
  List<Object> get props => [];
}

class CreateChallengeClicked extends CreateChallengeEvent {
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

  const CreateChallengeClicked({
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
  List<Object> get props => [
        challengeType,
        challengeTitle,
        challengeTarget,
        challengeStartDate,
        challengeEndDate,
        challengeDetails,
        challengeImage.toString(),
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
