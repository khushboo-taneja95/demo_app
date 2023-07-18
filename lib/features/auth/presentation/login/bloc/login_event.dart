part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginBtnClicked extends LoginEvent {
  String email;
  String password;

  LoginBtnClicked({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
