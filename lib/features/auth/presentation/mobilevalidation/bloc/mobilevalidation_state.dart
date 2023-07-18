part of 'mobilevalidation_bloc.dart';

abstract class MobilevalidationState extends Equatable {
  const MobilevalidationState();
  @override
  List<Object> get props => [];
}

class MobilevalidationInitial extends MobilevalidationState {}

class MobilevalidationLoading extends MobilevalidationState {}

class MobilevalidationSuccess extends MobilevalidationState {
  final String message;

  MobilevalidationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MobilevalidationFailure extends MobilevalidationState {
  final String message;

  MobilevalidationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class PhoneAuthError extends MobilevalidationState {
  final String error;

  const PhoneAuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class PhoneAuthVerified extends MobilevalidationState {}

class PhoneAuthCodeSentSuccess extends MobilevalidationState {
  final String verificationId;
  const PhoneAuthCodeSentSuccess({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class TimerTickState extends MobilevalidationState {
  final int sec;
  const TimerTickState({required this.sec});

  @override
  List<Object> get props => [sec];
}
