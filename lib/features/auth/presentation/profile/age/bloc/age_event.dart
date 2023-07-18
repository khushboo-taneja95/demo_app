part of 'age_bloc.dart';

abstract class AgeEvent extends Equatable {
  const AgeEvent();
}

class SaveAgeBtnClicked extends AgeEvent {
  final DateTime dob;
  final bool isEditing;
  const SaveAgeBtnClicked(this.dob, {this.isEditing = false});
  @override
  List<Object?> get props => [dob, isEditing];
}
