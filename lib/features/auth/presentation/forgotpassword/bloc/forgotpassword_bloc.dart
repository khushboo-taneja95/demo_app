import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/di/injection.dart';
import '../../../domain/usecases/forgotpassword_via_email_usecase.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  ForgotpasswordBloc() : super(ForgotpasswordInitial()) {
    on<ForgotpasswordEvent>((event, emit) {});
    on<ForgotPasswordBtnClicked>(_forgotPasswordBtnClicked);
  }

  void _forgotPasswordBtnClicked(ForgotPasswordBtnClicked event, Emitter<ForgotpasswordState> emit) async {
    emit(ForgotPasswordLoading());
    //api call via repository
    final data = await ForgotPasswordViaEmail(repository: getIt())
        .call(forgotPasswordParams(Emailid: event.Emailid));
    data.fold((l) {
      emit(ForgotPasswordFailure(message: l.message));
    }, (r) {
      emit(ForgotPasswordSuccess(message: "Password sent to your Email Id."));
    });
  }

}
