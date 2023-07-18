part of 'terms_and_conditions_bloc.dart';

abstract class TermsAndConditionsState extends Equatable {
  const TermsAndConditionsState();
  @override
  List<Object> get props => [];
}

class SmsOtpInitial extends TermsAndConditionsState {

}

class ToggleCheckboxState extends TermsAndConditionsState {
 bool isChecked;

 ToggleCheckboxState({required  this.isChecked});

 @override
 List<Object> get props => [isChecked];

}

class SendControllerWebview extends TermsAndConditionsState {
   WebViewController webViewController = WebViewController();

   SendControllerWebview({required this.webViewController});

  @override
  List<Object> get props => [webViewController];
}

class TermsOfServiceLoading extends TermsAndConditionsState {}

class TermsOfServiceSuccess extends TermsAndConditionsState {
  final String message;

  TermsOfServiceSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TermsOfServiceFailure extends TermsAndConditionsState {
  final String message;

  TermsOfServiceFailure({required this.message});

  @override
  List<Object> get props => [message];
}
