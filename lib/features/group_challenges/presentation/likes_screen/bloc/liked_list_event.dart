part of 'liked_list_bloc.dart';

abstract class LikeListEvent extends Equatable {
  const LikeListEvent();

  @override
  List<Object> get props => [];
}

class LikeListLoadedEvent extends LikeListEvent {
  const LikeListLoadedEvent();
  @override
  List<Object> get props => [];
}

class LikeListLoadEvent extends LikeListEvent {
  const LikeListLoadEvent();

  @override
  List<Object> get props => [];
}

class LikeListClicked extends LikeListEvent {
  final int startIndex;
  final int pageSize;
  final String uid;
  final int challengeid;

  const LikeListClicked(
      {required this.startIndex,
      required this.pageSize,
      required this.uid,
      required this.challengeid});

  @override
  List<Object> get props => [
        startIndex,
        pageSize,
        uid,
        challengeid,
      ];
}

// class LikeUnlikeClicked extends LikeListEvent {
//   final String challengeid;
//   final String reaction;
//   final String reacted_by;
//   final String participant_uid;

//   const LikeUnlikeClicked(
//       {required this.challengeid,
//       required this.reaction,
//       required this.reacted_by,
//       required this.participant_uid});

//   @override
//   List<Object> get props =>
//       [challengeid, reaction, reacted_by, participant_uid];
// }
