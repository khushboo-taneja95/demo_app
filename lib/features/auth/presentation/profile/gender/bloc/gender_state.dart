part of 'gender_bloc.dart';

abstract class GenderState extends Equatable {
  const GenderState();
}

class GenderInitial extends GenderState {
  @override
  List<Object> get props => [];
}

class GenderSaved extends GenderState {
  final String gender;

  const GenderSaved(this.gender);

  @override
  List<Object?> get props => [gender];
}
