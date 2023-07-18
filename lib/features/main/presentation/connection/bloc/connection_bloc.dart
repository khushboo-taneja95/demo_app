import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/constants/watch_constants.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/main/domain/usecases/update_device_type_usecase.dart';
import 'package:tres_connect/foreground_service.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class DeviceConnectionBloc
    extends Bloc<DeviceConnectionEvent, DeviceConnectionState> {
  List<Map<dynamic, dynamic>> deviceList = [];

  DeviceConnectionBloc(super.initialState);

  FutureOr<void> _bluetoothStateChanged(
    BluetoothStateChanged event,
    Emitter<DeviceConnectionState> emit,
  ) {
    if (event.state == 0) {
      emit(ScanStarted());
      emit(DeviceConnectionInitial(bluetoothState: event.state));
    }
  }
}
