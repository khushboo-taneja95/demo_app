import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/utility/utils.dart';

import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/features/auth/presentation/terms_and_conditions/bloc/terms_and_conditions_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/widgets/tres_btn.dart';

class TermsAndConditionsPage extends StatelessWidget {
  final String mobileno;

  TermsAndConditionsPage({required this.mobileno, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TermsAndConditionsBloc(authRepository: getIt()),
      child: Scaffold(
        body: SmsOtpBody(
          mobileno: mobileno,
        ),
      ),
    );
  }
}

class SmsOtpBody extends StatelessWidget {
  final String mobileno;

  SmsOtpBody({super.key, required this.mobileno});

  WebViewController? webViewController;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TermsAndConditionsBloc, TermsAndConditionsState>(
      listener: (context, state) {
        if (state is ToggleCheckboxState) {
          isChecked = state.isChecked;
        } else if (state is SendControllerWebview) {
          webViewController = state.webViewController;
        } else if (state is TermsOfServiceLoading) {
          Utils.showLoaderDialog(context);
        } else if (state is TermsOfServiceSuccess) {
          Navigator.pop(context);
          Utils.showSnackBar(context, state.message);
          Navigator.pushNamed(context, Routes.home);
        } else if (state is TermsOfServiceFailure) {
          Navigator.pop(context);
          Utils.showSnackBar(context, state.message);
        }
      },
      child: BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
        builder: (context, state) {
          if (state is SmsOtpInitial) {
            context
                .read<TermsAndConditionsBloc>()
                .add(SendWebviewControllerEvent());
          }

          return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Terms and conditions",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: webViewController != null
                              ? WebViewWidget(controller: webViewController!)
                              : Container()),
                      CheckboxListTile(
                        title: const Text(
                            "I agree to above terms & conditions.",
                            style: TextStyle(fontSize: 13)),
                        value: isChecked,
                        onChanged: (newValue) {
                          context
                              .read<TermsAndConditionsBloc>()
                              .add(ToggleCheckboxEvent(isChecked: newValue!));
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      MyButton(
                        text: "Continue",
                        bgColor: Palette.greenbtn,
                        onClick: () {
                          if (!isChecked!) {
                            Utils.showSnackBar(context,
                                "Please accept Terms in use to continue.");
                          } else {
                            var pref = getIt<SharedPreferences>();
                            var uid = pref.getString("uid");
                            context.read<TermsAndConditionsBloc>().add(
                                TermsConditionBtnClicked(
                                    uid: uid!,
                                    username: "",
                                    mobileno: mobileno));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
