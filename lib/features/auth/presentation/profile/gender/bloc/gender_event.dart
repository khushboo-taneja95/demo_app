part of 'gender_bloc.dart';

abstract class GenderEvent extends Equatable {
  const GenderEvent();
}

class SaveGenderBtnClicked extends GenderEvent {
  bool isEditing;
  String gender;
  SaveGenderBtnClicked(this.gender, {this.isEditing = false});

  @override
  List<Object?> get props => [gender];
}
