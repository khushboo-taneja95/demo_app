import 'package:equatable/equatable.dart';

import '../../../../data/models/get_all_badges_model.dart';

abstract class AllBadgesState extends Equatable {
  const AllBadgesState();

  @override
  List<Object> get props => [];
}

class AllBadgesInitial extends AllBadgesState {}

class AllBadgesLoading extends AllBadgesState {}

class AllBadgesLoaded extends AllBadgesState {
  final List<GetAllBadgeByUserId> getAllBadgeByUserId;
  const AllBadgesLoaded({required this.getAllBadgeByUserId});

  @override
  List<Object> get props => [getAllBadgeByUserId];
}

class AllBadgesError extends AllBadgesState {
  final String message;
  const AllBadgesError({required this.message});
  @override
  List<Object> get props => [message];
}
