part of 'mobilevalidation_bloc.dart';

abstract class MobilevalidationEvent extends Equatable {
  const MobilevalidationEvent();

  @override
  List<Object> get props => [];
}

class MobilevalidationBtnClicked extends MobilevalidationEvent {
  String mobileno;

  MobilevalidationBtnClicked({required this.mobileno});

  @override
  List<Object> get props => [mobileno];
}

class SendOtpToPhoneEvent extends MobilevalidationEvent {
  final String phoneNumber;

  const SendOtpToPhoneEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class TimerEvent extends MobilevalidationEvent {
  final bool isStart;
  const TimerEvent({required this.isStart});
  @override
  List<Object> get props => [];
}

class ReSendOtpToPhoneEvent extends MobilevalidationEvent {
  final String phoneNumber;

  const ReSendOtpToPhoneEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifySentOtpEvent extends MobilevalidationEvent {
  final String otpCode;
  final String verificationId;

  const VerifySentOtpEvent(
      {required this.otpCode, required this.verificationId});

  @override
  List<Object> get props => [otpCode, verificationId];
}

class OnPhoneOtpSent extends MobilevalidationEvent {
  final String verificationId;
  final int? token;
  const OnPhoneOtpSent({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

class OnPhoneAuthErrorEvent extends MobilevalidationEvent {
  final String error;
  const OnPhoneAuthErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class OnPhoneAuthVerificationCompleteEvent extends MobilevalidationEvent {
  final AuthCredential credential;
  const OnPhoneAuthVerificationCompleteEvent({
    required this.credential,
  });
}
