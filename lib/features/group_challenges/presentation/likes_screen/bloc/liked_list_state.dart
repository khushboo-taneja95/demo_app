part of 'liked_list_bloc.dart';

abstract class LikeListState extends Equatable {
  const LikeListState();

  @override
  List<Object> get props => [];
}

class LikedListInitial extends LikeListState {}

class LikedListLoading extends LikeListState {}

class LikedListLoaded extends LikeListState {
  final List<ListOfLikesChallenge> listOfLikesChallenge;
  const LikedListLoaded({required this.listOfLikesChallenge});

  @override
  List<Object> get props => [listOfLikesChallenge];
}

// class LikeUnlikeLoaded extends LikeListState {
//   final String challengeid;
//   final String participant_uid;
//   final String reacted_by;
//   final String reaction;
//   const LikeUnlikeLoaded({
//     required this.challengeid,
//     required this.participant_uid,
//     required this.reacted_by,
//     required this.reaction,
//   });
//   @override
//   List<Object> get props => [
//         challengeid,
//         participant_uid,
//         reacted_by,
//         reaction,
//       ];
// }
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

class LikeListError extends LikeListState {
  final String message;
  const LikeListError({required this.message});
  @override
  List<Object> get props => [message];
}
