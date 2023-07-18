part of 'past_challenges_bloc.dart';

abstract class PastChallengesState extends Equatable {
  const PastChallengesState();

  @override
  List<Object> get props => [];
}

class PastChallengesInitial extends PastChallengesState {}

class PastChallengesLoading extends PastChallengesState {
  const PastChallengesLoading();
  @override
  List<Object> get props => [];
}

class PastChallengesError extends PastChallengesState {
  final String message;
  const PastChallengesError({required this.message});
  @override
  List<Object> get props => [message];
}

class PastChallengesLoaded extends PastChallengesState {
  final List<GetChallenges> challenges;
  final List<GetChallenges> globalChallenges;
  final List<GetChallenges> corporateChallenges;
  final List<GetChallenges> groupChallenges;
  const PastChallengesLoaded(
      {required this.challenges,
      required this.globalChallenges,
      required this.corporateChallenges,
      required this.groupChallenges});

  @override
  List<Object> get props =>
      [challenges, globalChallenges, corporateChallenges, groupChallenges];
}
