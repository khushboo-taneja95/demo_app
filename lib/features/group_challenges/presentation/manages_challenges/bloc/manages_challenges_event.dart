part of 'manages_challenges_bloc.dart';

abstract class ManagesChallengesEvent extends Equatable {
  const ManagesChallengesEvent();

  @override
  List<Object?> get props => [];
}

class LoadManagesChallenges extends ManagesChallengesEvent {
  final bool fromRemote;
  const LoadManagesChallenges({this.fromRemote = false});

  @override
  List<Object?> get props => [fromRemote];
}
