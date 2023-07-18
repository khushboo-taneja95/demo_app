part of 'past_challenges_bloc.dart';

abstract class PastChallengesEvent extends Equatable {
  const PastChallengesEvent();

  @override
  List<Object> get props => [];
}

class LoadPastChallengesEvent extends PastChallengesEvent {
  final String uid;
  const LoadPastChallengesEvent({required this.uid});

  @override
  List<Object> get props => [];
}
