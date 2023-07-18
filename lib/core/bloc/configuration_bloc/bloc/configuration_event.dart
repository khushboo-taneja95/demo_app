part of 'configuration_bloc.dart';

abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object> get props => [];
}

class ConfigurationLoadEvent extends ConfigurationEvent {
  const ConfigurationLoadEvent();

  @override
  List<Object> get props => [];
}
