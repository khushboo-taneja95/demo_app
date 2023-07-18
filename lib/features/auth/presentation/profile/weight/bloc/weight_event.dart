part of 'weight_bloc.dart';

abstract class WeightEvent extends Equatable {
  const WeightEvent();
}

class SaveWeightBtnClicked extends WeightEvent {
  final int weight;
  final bool isEditing;
  const SaveWeightBtnClicked(this.weight, {this.isEditing = false});
  @override
  List<Object?> get props => [];
}
