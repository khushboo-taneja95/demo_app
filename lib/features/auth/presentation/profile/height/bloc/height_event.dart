part of 'height_bloc.dart';

abstract class HeightEvent extends Equatable {
  const HeightEvent();
}

class SaveHeightBtnClicked extends HeightEvent {
  final int height;
  final bool isEditing;
  const SaveHeightBtnClicked(this.height, {this.isEditing = false});
  @override
  List<Object?> get props => [];
}
