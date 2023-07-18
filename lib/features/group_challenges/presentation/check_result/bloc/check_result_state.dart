import 'package:equatable/equatable.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';

import '../../../data/models/get_check_result_model.dart';

abstract class CheckResultState extends Equatable {
  const CheckResultState();

  @override
  List<Object> get props => [];
}

class CheckResultInitial extends CheckResultState {}

class CheckResultLoading extends CheckResultState {}

class CheckResultLoaded extends CheckResultState {
  final CheckResult checkResult;
  const CheckResultLoaded({required this.checkResult});

  @override
  List<Object> get props => [checkResult];
}

class OnPastChallengeLoaded extends CheckResultState {
  final List<GetChallenges> challenges;
  final List<GetChallenges> globalChallenges;
  final List<GetChallenges> corporateChallenges;
  final List<GetChallenges> groupChallenges;
  const OnPastChallengeLoaded(
      {required this.challenges,
      required this.globalChallenges,
      required this.corporateChallenges,
      required this.groupChallenges});

  @override
  List<Object> get props => [challenges];
}

class CheckResultError extends CheckResultState {
  final String message;
  const CheckResultError({required this.message});
  @override
  List<Object> get props => [message];
}
