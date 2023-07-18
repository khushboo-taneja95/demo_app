part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeSuccess extends WelcomeState {
  final String routeName;
  const WelcomeSuccess({required this.routeName});

  @override
  List<Object> get props => [routeName];

}

class WelcomeFailure extends WelcomeState {
  final String message;

  const WelcomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}
