part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  String routeName;
  Map<String, dynamic> arguments;
  LoginSuccess({required this.routeName, required this.arguments});

  @override
  List<Object> get props => [routeName];
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}
