part of 'connection_bloc.dart';

abstract class DeviceConnectionEvent extends Equatable {
  const DeviceConnectionEvent();

  @override
  List<Object> get props => [];
}

class CheckConnected extends DeviceConnectionEvent {}

class ConnectionStateChanged extends DeviceConnectionEvent {
  final String deviceName;
  final String address;
  final bool isConnected;

  const ConnectionStateChanged({required this.deviceName, required this.address, required this.isConnected});

  @override
  List<Object> get props => [deviceName, address, isConnected];
}

class BondStateChanged extends DeviceConnectionEvent {
  final String address;

  const BondStateChanged({required this.address});

  @override
  List<Object> get props => [address];
}

class BluetoothStateChanged extends DeviceConnectionEvent {
  final int state;

  const BluetoothStateChanged({required this.state});

  @override
  List<Object> get props => [state];
}

class ScanBtnClicked extends DeviceConnectionEvent {}

class StopScanBtnClicked extends DeviceConnectionEvent {}

class BluetoothDeviceClicked extends DeviceConnectionEvent {
  final String name;
  final String address;

  const BluetoothDeviceClicked({required this.name, required this.address});

  @override
  List<Object> get props => [name, address];
}

class UnpairBtnClicked extends DeviceConnectionEvent {}