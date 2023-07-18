import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/features/auth/domain/usecases/update_user_name_usecase.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

part 'terms_and_conditions_event.dart';
part 'terms_and_conditions_state.dart';

class TermsAndConditionsBloc
    extends Bloc<TermsAndConditionsEvent, TermsAndConditionsState> {
  final AuthRepository authRepository;

  TermsAndConditionsBloc({required this.authRepository})
      : super(SmsOtpInitial()) {
    on<SendWebviewControllerEvent>(_intialised);
    on<ToggleCheckboxEvent>(_ischecboxchecked);
    on<TermsConditionBtnClicked>(_termsconditionsBtnClicked);
  }

  void _ischecboxchecked(
      ToggleCheckboxEvent event, Emitter<TermsAndConditionsState> emitter) {
    emitter(ToggleCheckboxState(isChecked: event.isChecked));
  }

  void _intialised(SendWebviewControllerEvent event,
      Emitter<TermsAndConditionsState> emit) async {
    //api call via repository
    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://www.tres.in/html/terms-of-service.html')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://www.tres.in/html/terms-of-service.html'));
    emit(SendControllerWebview(webViewController: webViewController));
  }

  void _termsconditionsBtnClicked(TermsConditionBtnClicked event,
      Emitter<TermsAndConditionsState> emit) async {
    emit(TermsOfServiceLoading());
    //api call via repository
    final data = await UpdateUserName(repository: getIt()).call(
        UpdateUserNameParams(
            uid: event.uid,
            username: event.username,
            mobileno: event.mobileno));
    data.fold((l) {
      emit(TermsOfServiceFailure(message: l.message));
    }, (r) {
      emit(TermsOfServiceSuccess(message: r.errorMessage!));
    });
  }
}
