part of 'ongoing_challenges_bloc.dart';

abstract class OnGoingChallengeState extends Equatable {
  const OnGoingChallengeState();

  @override
  List<Object?> get props => [];
}

class OnGoingChallengeInitial extends OnGoingChallengeState {}

class OnGoingChallengeLoading extends OnGoingChallengeState {}

class OnGoingChallengeLoaded extends OnGoingChallengeState {
  final List<GetChallenges> challenges;
  final List<GetChallenges> globalChallenges;
  final List<GetChallenges> corporateChallenges;
  final List<GetChallenges> groupChallenges;
  const OnGoingChallengeLoaded(
      {required this.challenges,
      required this.globalChallenges,
      required this.corporateChallenges,
      required this.groupChallenges});

  @override
  List<Object?> get props => [challenges];
}

class OnGoingChallengeError extends OnGoingChallengeState {
  final String message;
  const OnGoingChallengeError({required this.message});
  @override
  List<Object> get props => [message];
}
