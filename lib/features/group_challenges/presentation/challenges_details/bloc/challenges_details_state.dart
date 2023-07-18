part of 'challenges_details_bloc.dart';

abstract class ChallengeDetailsState extends Equatable {
  const ChallengeDetailsState();

  @override
  List<Object> get props => [];
}

class ChallengeDetailsInitial extends ChallengeDetailsState {}

class ChallengeDetailsLoading extends ChallengeDetailsState {}

class ChallengeDetailsLoaded extends ChallengeDetailsState {
  final String uid;
  final String challengeId;
  final bool isJoined;

  const ChallengeDetailsLoaded({
    required this.uid,
    this.isJoined = false,
    required this.challengeId,
  });

  @override
  List<Object> get props => [
        uid,
        challengeId,
      ];
}

class ChallengeDetailsSuccess extends ChallengeDetailsState {
  final String message;

  ChallengeDetailsSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class LeaveChallengesLoaded extends ChallengeDetailsState {
  final String challengeId;
  final String participantUid;

  const LeaveChallengesLoaded({
    required this.challengeId,
    required this.participantUid,
  });

  @override
  List<Object> get props => [
        challengeId,
        participantUid,
      ];
}

class ChallengeDetailsError extends ChallengeDetailsState {
  final String message;
  const ChallengeDetailsError({required this.message});
  @override
  List<Object> get props => [message];
}
