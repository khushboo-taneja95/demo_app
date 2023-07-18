part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}


class DashboardInitialEvent extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class AskPermissionEvent extends DashboardEvent{
  @override
  List<Object> get props => [];
}