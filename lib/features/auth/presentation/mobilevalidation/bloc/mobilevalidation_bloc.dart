import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/usecases/verify_phone_no_usecase.dart';

part 'mobilevalidation_event.dart';
part 'mobilevalidation_state.dart';

class MobileValidationBloc
    extends Bloc<MobilevalidationEvent, MobilevalidationState> {
  final AuthRepository authRepository;
  final auth = FirebaseAuth.instance;
  final int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  MobileValidationBloc({required this.authRepository})
      : super(MobilevalidationInitial()) {
    // When user clicks on send otp button then this event will be fired

    on<MobilevalidationBtnClicked>(_mobileValidationBtnClicked);

    on<SendOtpToPhoneEvent>(_onSendOtp);

    // After receiving the otp, When user clicks on verify otp button then this event will be fired
    on<VerifySentOtpEvent>(_onVerifyOtp);

    // Resend otp
    on<ReSendOtpToPhoneEvent>(_onResendOtp);

    on<TimerEvent>(_timerStarted);

    // When the firebase sends the code to the user's phone, this event will be fired
    on<OnPhoneOtpSent>((event, emit) {
      emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
      add(const TimerEvent(isStart: true));
    });

    // When any error occurs while sending otp to the user's phone, this event will be fired
    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // When the otp verification is successful, this event will be fired
    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);
  }

  void _timerStarted(
      TimerEvent event, Emitter<MobilevalidationState> emit) async {
    var timerSeconds = 60;
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerSeconds == 0) {
          timer.cancel();
        } else {
          timerSeconds--;
        }
        emit(TimerTickState(sec: timerSeconds));
      },
    );
    await Future.delayed(Duration(seconds: timerSeconds + 3));
  }

  void _mobileValidationBtnClicked(MobilevalidationBtnClicked event,
      Emitter<MobilevalidationState> emit) async {
    emit(MobilevalidationLoading());
    //api call via repository
    final data = await MobileValidationViaEmail(repository: getIt())
        .call(MobilevalidationParams(mobileno: event.mobileno));
    data.fold((l) {
      emit(MobilevalidationFailure(message: l.message));
    }, (r) {
      emit(MobilevalidationSuccess(message: r.errorMessage!));
    });
  }

  Future<void> _onResendOtp(
      ReSendOtpToPhoneEvent event, Emitter<MobilevalidationState> emit) async {
    emit(MobilevalidationLoading());
    try {
      await authRepository.verifyPhoneNo(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // On [verificationComplete], we will get the credential from the firebase  and will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
          add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          // On [codeSent], we will get the verificationId and the resendToken from the firebase and will send it to the [OnPhoneOtpSent] event to be handled by the bloc and then will emit the [OnPhoneAuthVerificationCompleteEvent] event after receiving the code from the user's phone
          add(OnPhoneOtpSent(
              verificationId: verificationId, token: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          // On [verificationFailed], we will get the exception from the firebase and will send it to the [OnPhoneAuthErrorEvent] event to be handled by the bloc and then will emit the [PhoneAuthError] state in order to display the error to the user's screen
          add(OnPhoneAuthErrorEvent(error: e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  Future<void> _onSendOtp(
      SendOtpToPhoneEvent event, Emitter<MobilevalidationState> emit) async {
    emit(MobilevalidationLoading());
    try {
      await authRepository.verifyPhoneNo(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // On [verificationComplete], we will get the credential from the firebase  and will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
          add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          // On [codeSent], we will get the verificationId and the resendToken from the firebase and will send it to the [OnPhoneOtpSent] event to be handled by the bloc and then will emit the [OnPhoneAuthVerificationCompleteEvent] event after receiving the code from the user's phone
          add(OnPhoneOtpSent(
              verificationId: verificationId, token: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          // On [verificationFailed], we will get the exception from the firebase and will send it to the [OnPhoneAuthErrorEvent] event to be handled by the bloc and then will emit the [PhoneAuthError] state in order to display the error to the user's screen
          add(OnPhoneAuthErrorEvent(error: e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
      OnPhoneAuthVerificationCompleteEvent event,
      Emitter<MobilevalidationState> emit) async {
    // After receiving the credential from the event, we will login with the credential and then will emit the [PhoneAuthVerified] state after successful login
    try {
      await auth.signInWithCredential(event.credential).then((user) {
        if (user.user != null) {
          emit(PhoneAuthVerified());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthError(error: e.code));
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
      VerifySentOtpEvent event, Emitter<MobilevalidationState> emit) async {
    try {
      emit(MobilevalidationLoading());
      // After receiving the otp, we will verify the otp and then will create a credential from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
    }
  }
}
