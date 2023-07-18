part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterBtnClicked extends RegisterEvent {
  String name;
  String email;
  String password;

  RegisterBtnClicked(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
