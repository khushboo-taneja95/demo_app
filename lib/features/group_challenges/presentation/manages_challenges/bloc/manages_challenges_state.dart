part of 'manages_challenges_bloc.dart';

abstract class ManageChallengesState extends Equatable {
  const ManageChallengesState();
  @override
  List<Object?> get props => [];
}

class ManageChallengesInitial extends ManageChallengesState {}

class ManageChallengesLoading extends ManageChallengesState {}

class ManagesChallengesLoaded extends ManageChallengesState {
  final File? file;
  final String? challengesName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? targetName;
  final String? challengesDetails;

  const ManagesChallengesLoaded({
    this.file,
    this.challengesName,
    this.startDate,
    this.endDate,
    this.targetName,
    this.challengesDetails,
  });

  @override
  List<Object?> get props => [
        file,
        challengesName,
        startDate,
        endDate,
        targetName,
        challengesDetails,
      ];
}

class ManageChallengesError extends ManageChallengesState {
  final String message;
  const ManageChallengesError({required this.message});
  @override
  List<Object> get props => [message];
}
