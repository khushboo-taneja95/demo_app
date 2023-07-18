import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';

import 'package:tres_connect/core/di/injection.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc(super.initialState);

  void _globalInitialize(
    GlobalInitialize event,
    Emitter<GlobalState> emit,
  ) async {
    emit(GlobalLoading());

    emit(GlobalInitial());
  }

  String deviceAddress =
      getIt<SharedPreferences>().getString("device_address") ?? "";
  String deviceName = getIt<SharedPreferences>().getString("device_name") ??
      "No Device Connected";
}
