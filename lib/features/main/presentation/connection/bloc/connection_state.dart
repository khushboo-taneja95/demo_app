part of 'connection_bloc.dart';

abstract class DeviceConnectionState extends Equatable {
  const DeviceConnectionState();

  @override
  List<Object> get props => [];
}

class DeviceConnectionLoading extends DeviceConnectionState {}

class DeviceConnectionInitial extends DeviceConnectionState {
  int bluetoothState;
  DeviceConnectionInitial({this.bluetoothState = -1});

  @override
  List<Object> get props => [bluetoothState];
}

class ScanStarted extends DeviceConnectionState {}

class ScanStopped extends DeviceConnectionState {}

class DeviceConnecting extends DeviceConnectionState {}

class DeviceConnected extends DeviceConnectionState {
  final String deviceName;
  final String address;

  const DeviceConnected({required this.deviceName, required this.address});

  @override
  List<Object> get props => [deviceName, address];
}

class DeviceDisconnected extends DeviceConnectionState {}
