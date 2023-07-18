part of 'global_bloc.dart';

class GlobalState extends Equatable {
  GlobalState();

  @override
  List<Object> get props => [];

  GlobalState copyWith({
    String? customProperty,
  }) {
    return GlobalState();
  }
}

class GlobalInitial extends GlobalState {}

class GlobalLoading extends GlobalState {}

class GlobalError extends GlobalState {
  final String message;

  GlobalError({required this.message});

  @override
  List<Object> get props => [message];
}

class GlobalDataFetched extends GlobalState {
  final String type;

  GlobalDataFetched({this.type = ""});

  @override
  List<Object> get props => [type];
}

class GlobalDeviceSettingsFetched extends GlobalState {
  GlobalDeviceSettingsFetched();

  @override
  List<Object> get props => [];
}

class GlobalActivitySummaryLoaded extends GlobalState {
  final List<ActivitySummary> activitySummaryList;

  GlobalActivitySummaryLoaded({required this.activitySummaryList});

  @override
  List<Object> get props => [activitySummaryList];
}

class GlobalActivityDetailsLoaded extends GlobalState {
  final List<ActivityDetails> activityDetailsList;

  GlobalActivityDetailsLoaded({required this.activityDetailsList});

  @override
  List<Object> get props => [activityDetailsList];
}

class GlobalHealthReadingsLoaded extends GlobalState {
  final List<HealthReading> healthReadingList;

  GlobalHealthReadingsLoaded({required this.healthReadingList});

  @override
  List<Object> get props => [healthReadingList];
}
