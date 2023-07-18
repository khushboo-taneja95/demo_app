part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardLoadingState extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardReady extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardPermissionDenied extends DashboardState {
  List<PermissionStatus> deniedPermissions;

  DashboardPermissionDenied({required this.deniedPermissions});

  @override
  List<Object> get props => [deniedPermissions];
}

class DashboardPermissionGranted extends DashboardState {
  @override
  List<Object> get props => [];
}