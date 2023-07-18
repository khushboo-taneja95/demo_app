part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class LoginWithFacebookBtnClicked extends WelcomeEvent {}

class LoginWithGoogleBtnClicked extends WelcomeEvent {}

class LoginWithAppleBtnClicked extends WelcomeEvent {}
