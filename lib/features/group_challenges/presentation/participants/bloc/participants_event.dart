part of 'participants_bloc.dart';

abstract class ParticipantEvent extends Equatable {
  const ParticipantEvent();

  @override
  List<Object> get props => [];
}

class ParticipantLoadedEvent extends ParticipantEvent {
  const ParticipantLoadedEvent();
  @override
  List<Object> get props => [];
}

class ParticipantLoadEvent extends ParticipantEvent {
  const ParticipantLoadEvent();

  @override
  List<Object> get props => [];
}

class ParticipantClicked extends ParticipantEvent {
  final String search;
  final String id;
  final String pagesize;

  const ParticipantClicked(
      {required this.pagesize,
      required this.id,
      required this.search,
      required String challengeId,
      required String uid});

  @override
  List<Object> get props => [search, id, pagesize];
}

class LikeUnlikeClicked extends ParticipantEvent {
  final String challengeid;
  final String reaction;
  final String reacted_by;
  final String participant_uid;

  const LikeUnlikeClicked(
      {required this.challengeid,
      required this.reaction,
      required this.reacted_by,
      required this.participant_uid});

  @override
  List<Object> get props =>
      [challengeid, reaction, reacted_by, participant_uid];
}
