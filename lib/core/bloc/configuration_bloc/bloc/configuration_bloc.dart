import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/global_configuration.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc() : super(ConfigurationInitial()) {
    on<ConfigurationLoadEvent>(_loadConfiguration);
  }

  void _loadConfiguration(
      ConfigurationLoadEvent event, Emitter<ConfigurationState> emit) {
    emit(ConfiguratonLoading());
    GlobalConfiguration globalConfiguration = getIt<GlobalConfiguration>();
    emit(ConfigurationLoaded(globalConfiguration: globalConfiguration));
  }
}
