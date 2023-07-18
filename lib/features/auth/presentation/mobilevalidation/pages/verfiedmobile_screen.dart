import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/auth/presentation/mobilevalidation/bloc/mobilevalidation_bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/widgets/my_text_field.dart';
import 'package:tres_connect/widgets/tres_btn.dart';

import '../../../../../core/utility/EncodeUtils.dart';

class VerfiedMobilePage extends StatelessWidget {
  const VerfiedMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileValidationBloc(authRepository: getIt()),
      child: Scaffold(
        body: VerfiyMobileBody(),
      ),
    );
  }
}

class VerfiyMobileBody extends StatelessWidget {
  bool isOTP = false;
  bool isActiveResend = false;
  TextEditingController mobileController = TextEditingController();
  String otp = "";
  String verificationId = "";
  int secToShow = 60;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MobileValidationBloc, MobilevalidationState>(
      listener: (context, state) {
        if (state is MobilevalidationLoading) {
          Utils.showLoaderDialog(context);
        }
        if (state is MobilevalidationFailure) {
          Navigator.pop(context);
          Utils.showSnackBar(context, state.message);
        } else if (state is MobilevalidationSuccess) {
          Navigator.pop(context);
          context.read<MobileValidationBloc>().add(
              SendOtpToPhoneEvent(phoneNumber: "+91${mobileController.text}"));
          // verificationId = state.verificationId;
        } else if (state is PhoneAuthCodeSentSuccess) {
          Navigator.pop(context);
          verificationId = state.verificationId;
          isOTP = true;
        } else if (state is PhoneAuthError) {
          Navigator.pop(context);
          isOTP = false;
          Utils.showSnackBar(context, state.error);
        } else if (state is PhoneAuthVerified) {
          isOTP = false;
          Utils.showSnackBar(context, "Phone number verified successfully");
          Navigator.pushNamed(context, Routes.smsOtp,
              arguments: "91${mobileController.text}");
        } else if (state is TimerTickState) {
          secToShow = state.sec;
        }
      },
      child: BlocBuilder<MobileValidationBloc, MobilevalidationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Update Mobile Number",
                style: TextStyle(color: Palette.surface),
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isOTP,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50, top: 20, bottom: 20),
                              child: Image.asset(
                                  "assets/images/mobile_graphic.png"),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Enter New Mobile Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                      child: Text('+91 '),
                                    ),
                                    const Text(
                                      "|",
                                      style: TextStyle(
                                          fontSize: 33, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      maxLength: 10,
                                      initialValue:
                                          '${EncodeUtils.decodeBase64(getIt<GlobalConfiguration>().profile.mobileNo ?? "")}',
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: "Mobile Number",
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                              text: "Continue",
                              bgColor: Palette.greenbtn,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              onClick: () {
                                // else Utils.showSnackBar(context, "Enter Registered Email Id");
                                if (mobileController.text.length != 10) {
                                  Utils.showSnackBar(context,
                                      'Please enter valid mobile number');
                                  return;
                                } else {
                                  Utils.hideKeyboard();
                                  context.read<MobileValidationBloc>().add(
                                      MobilevalidationBtnClicked(
                                          mobileno:
                                              "91${mobileController.text}"));
                                }

                                // Navigator.pushNamed(context, Routes.registerPage);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text:
                                          'By clicking on continue button you are agree to our ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                    TextSpan(
                                      text: 'Terms of use',
                                      style: const TextStyle(
                                          color: Palette.termsofuse,
                                          fontSize: 15),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              Routes.termsAndConditions);
                                          // Single tapped.
                                        },
                                    ),
                                    const TextSpan(
                                        text: ' & ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15)),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: const TextStyle(
                                          color: Palette.termsofuse,
                                          fontSize: 15),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              Routes.privacyPolicyScreen);
                                          // Single tapped.
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: isOTP,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("$secToShow Seconds",
                                style: const TextStyle(
                                    color: Palette.secondaryColor1,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Enter the 6-digits OTP to",
                                style: TextStyle(
                                    color: Palette.darkgrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(mobileController.text,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OtpTextField(
                            numberOfFields: 6,
                            showFieldAsBox: true,
                            borderWidth: 2.0,
                            onCodeChanged: (String code) {
                              //handle validation or checks here if necessary
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              otp = verificationCode;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MyButton(
                            text: "Continue",
                            bgColor: Palette.greenbtn,
                            onClick: () {
                              if (otp.length < 6) {
                                Utils.showSnackBar(
                                    context, "Enter 6 digit OTP");
                              } else {
                                context.read<MobileValidationBloc>().add(
                                    VerifySentOtpEvent(
                                        otpCode: otp,
                                        verificationId: verificationId));
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                if (secToShow == 0) {
                                  context.read<MobileValidationBloc>().add(
                                      ReSendOtpToPhoneEvent(
                                          phoneNumber:
                                              "+91${mobileController.text}"));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please wait $secToShow seconds")));
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    isActiveResend
                                        ? "assets/images/otp_resend_active.png"
                                        : "assets/images/otp_resend.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Send Again",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
