part of 'challenges_details_bloc.dart';

abstract class ChallengeDetailsEvent extends Equatable {
  const ChallengeDetailsEvent();

  @override
  List<Object> get props => [];
}

class ChallengeDetailsLoadedEvent extends ChallengeDetailsEvent {
  final bool isJoined;
  final String uid;
  final String challengeId;
  const ChallengeDetailsLoadedEvent(
      {required this.uid, required this.challengeId, required this.isJoined});
  @override
  List<Object> get props => [uid, challengeId, isJoined];
}

class ChallengeDetailsClicked extends ChallengeDetailsEvent {
  final String uid;
  final String challengeId;

  const ChallengeDetailsClicked({
    required this.uid,
    required this.challengeId,
  });

  @override
  List<Object> get props => [
        uid,
        challengeId,
      ];
}

class LeaveChallengeClicked extends ChallengeDetailsEvent {
  final String challengeId;
  final String participantUid;

  const LeaveChallengeClicked({
    required this.challengeId,
    required this.participantUid,
  });

  @override
  List<Object> get props => [
        challengeId,
        participantUid,
      ];
}
