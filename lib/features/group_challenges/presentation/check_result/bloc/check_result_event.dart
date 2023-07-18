import 'package:equatable/equatable.dart';

abstract class CheckResultEvent extends Equatable {
  const CheckResultEvent();

  @override
  List<Object> get props => [];
}

class CheckResultLoadedEvent extends CheckResultEvent {
  const CheckResultLoadedEvent();
  @override
  List<Object> get props => [];
}

class CheckResultLoadEvent extends CheckResultEvent {
  const CheckResultLoadEvent();

  @override
  List<Object> get props => [];
}

class LoadPastChallengesEvent extends CheckResultEvent {
  final String uid;
  const LoadPastChallengesEvent({required this.uid});

  @override
  List<Object> get props => [];
}

class GetCheckResultClicked extends CheckResultEvent {
  final String uid;
  final int challengeid;

  const GetCheckResultClicked({required this.uid, required this.challengeid});

  @override
  List<Object> get props => [
        uid,
        challengeid,
      ];
}
