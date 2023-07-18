part of 'age_bloc.dart';

abstract class AgeState extends Equatable {
  const AgeState();
}

class AgeInitial extends AgeState {
  @override
  List<Object> get props => [];
}

class AgeSaved extends AgeState {
  @override
  List<Object?> get props => [];
}

class AgeLoading extends AgeState {
  @override
  List<Object?> get props => [];
}

class AgeError extends AgeState {
  final String message;
  AgeError(this.message);
  @override
  List<Object?> get props => [message];
}
