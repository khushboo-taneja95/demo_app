part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object?> get props => [];
}

class GlobalInitialize extends GlobalEvent {}

class SyncDeviceAndWatch extends GlobalEvent {
  const SyncDeviceAndWatch();

  @override
  List<Object?> get props => [];
}

class FetchActivitySummary extends GlobalEvent {}

class FetchActivityDetails extends GlobalEvent {}

class FetchHealthReadings extends GlobalEvent {
  final String medicalCode;

  const FetchHealthReadings({required this.medicalCode});

  @override
  List<Object?> get props => [medicalCode];
}

class HealthReadingsFetched extends GlobalEvent {
  final List<HealthReading> healthReadingList;

  const HealthReadingsFetched({required this.healthReadingList});

  @override
  List<Object?> get props => [healthReadingList];
}

class ActivitySummaryFetched extends GlobalEvent {
  final List<ActivitySummary> activitySummaryList;
  final String deviceName;
  final String deviceAddress;

  const ActivitySummaryFetched(
      {required this.activitySummaryList,
      required this.deviceName,
      required this.deviceAddress});

  @override
  List<Object?> get props => [activitySummaryList, deviceName, deviceAddress];
}

class ActivityDetailsFetched extends GlobalEvent {
  final List<ActivityDetails> activityDetailsList;

  const ActivityDetailsFetched({required this.activityDetailsList});

  @override
  List<Object?> get props => [activityDetailsList];
}

class FetchSleepDetails extends GlobalEvent {}

class SleepDetailsFetched extends GlobalEvent {
  final List<ActivityDetails> sleepDetailsList;

  const SleepDetailsFetched({required this.sleepDetailsList});

  @override
  List<Object?> get props => [sleepDetailsList];
}
