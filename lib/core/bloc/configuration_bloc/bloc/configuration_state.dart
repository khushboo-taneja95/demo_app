part of 'configuration_bloc.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfiguratonLoading extends ConfigurationState {}

class ConfigurationLoaded extends ConfigurationState {
  final GlobalConfiguration globalConfiguration;

  const ConfigurationLoaded({required this.globalConfiguration});

  @override
  List<Object> get props => [globalConfiguration];
}
