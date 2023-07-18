part of 'terms_and_conditions_bloc.dart';

abstract class TermsAndConditionsEvent extends Equatable {
  const TermsAndConditionsEvent();
}

class SendWebviewControllerEvent extends TermsAndConditionsEvent {
  SendWebviewControllerEvent();

  @override
  List<Object> get props => [];
}

class ToggleCheckboxEvent extends TermsAndConditionsEvent {
  final bool isChecked;

  const ToggleCheckboxEvent({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

class TermsConditionBtnClicked extends TermsAndConditionsEvent {
  String uid;
  String username;
  String mobileno;

  TermsConditionBtnClicked(
      {required this.uid, required this.username, required this.mobileno});

  @override
  List<Object> get props => [mobileno];
}
