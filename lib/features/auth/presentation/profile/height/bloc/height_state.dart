part of 'height_bloc.dart';

abstract class HeightState extends Equatable {
  const HeightState();
}

class HeightInitial extends HeightState {
  @override
  List<Object> get props => [];
}

class HeightSaved extends HeightState {
  @override
  List<Object?> get props => [];
}
