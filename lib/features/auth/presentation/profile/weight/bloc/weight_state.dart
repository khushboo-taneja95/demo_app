part of 'weight_bloc.dart';

abstract class WeightState extends Equatable {
  const WeightState();
}

class WeightInitial extends WeightState {
  @override
  List<Object> get props => [];
}

class WeightSaved extends WeightState {
  @override
  List<Object?> get props => [];
}
