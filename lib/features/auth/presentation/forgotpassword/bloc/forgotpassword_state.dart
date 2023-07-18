part of 'forgotpassword_bloc.dart';

abstract class ForgotpasswordState extends Equatable {
  const ForgotpasswordState();

  @override
  List<Object> get props => [];
}

class ForgotpasswordInitial extends ForgotpasswordState {
}

class ForgotPasswordLoading extends ForgotpasswordState {

}

class ForgotPasswordSuccess extends ForgotpasswordState {
  final String message;

  ForgotPasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ForgotPasswordFailure extends ForgotpasswordState {
  final String message;

  ForgotPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}
