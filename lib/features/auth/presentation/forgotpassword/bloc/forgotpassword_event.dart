part of 'forgotpassword_bloc.dart';

abstract class ForgotpasswordEvent extends Equatable {
  const ForgotpasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordBtnClicked extends ForgotpasswordEvent {
  String Emailid;

  ForgotPasswordBtnClicked({required this.Emailid});

  @override
  List<Object> get props => [Emailid];
}
