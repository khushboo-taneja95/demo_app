part of 'ongoing_challenges_bloc.dart';

abstract class OnGoingChallengeEvent extends Equatable {
  const OnGoingChallengeEvent();

  @override
  List<Object> get props => [];
}

class OnGoingChallengeList extends OnGoingChallengeEvent {}

class OnGoingChallengeLoadEvent extends OnGoingChallengeEvent {
  const OnGoingChallengeLoadEvent();

  @override
  List<Object> get props => [];
}
