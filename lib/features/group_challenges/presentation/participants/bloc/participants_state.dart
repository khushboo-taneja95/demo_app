part of 'participants_bloc.dart';

abstract class ParticipantState extends Equatable {
  const ParticipantState();

  @override
  List<Object> get props => [];
}

class ParticipantInitial extends ParticipantState {}

class ParticipantLoading extends ParticipantState {}

class ParticipantLoaded extends ParticipantState {
  final List<GetParticipants> getParticipants;
  const ParticipantLoaded({required this.getParticipants});

  @override
  List<Object> get props => [getParticipants];
}

class LikeUnlikeLoaded extends ParticipantState {
  final String challengeid;
  final String participant_uid;
  final String reacted_by;
  final String reaction;
  const LikeUnlikeLoaded({
    required this.challengeid,
    required this.participant_uid,
    required this.reacted_by,
    required this.reaction,
  });
  @override
  List<Object> get props => [
        challengeid,
        participant_uid,
        reacted_by,
        reaction,
      ];
}
// class ParticipantLoaded extends ParticipantState {
//   final List<GetParticipants> participants;

//   const ParticipantLoaded({required this.participants});
//   @override
//   List<Object> get props => [];
// }

// class LeaveChallengesLoaded extends ParticipantState {
//   final String challengeId;
//   final String participantUid;

//   const LeaveChallengesLoaded({
//     required this.challengeId,
//     required this.participantUid,
//   });

//   @override
//   List<Object> get props => [
//         challengeId,
//         participantUid,
//       ];
// }

class ParticipantError extends ParticipantState {
  final String message;
  const ParticipantError({required this.message});
  @override
  List<Object> get props => [message];
}
