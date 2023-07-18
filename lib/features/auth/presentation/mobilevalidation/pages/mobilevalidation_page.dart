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
import 'package:tres_connect/widgets/my_text_field.dart';
import 'package:tres_connect/widgets/tres_btn.dart';

class MobileValidationPage extends StatelessWidget {
  const MobileValidationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileValidationBloc(authRepository: getIt()),
      child: Scaffold(
        body: MobileValidationBody(),
      ),
    );
  }
}

class MobileValidationBody extends StatelessWidget {
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
                            const SizedBox(
                              height: 70,
                            ),
                            const Center(
                              child: Text("Verify your mobile number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50, top: 20, bottom: 20),
                              child: Image.asset(
                                  "assets/images/mobile_graphic.png"),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "For security enhancement of our app & existing new features, You are requested to update your & mobile number!",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Enter your Mobile Number",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: MyTextField(
                                  controller: mobileController,
                                  validator: (val) {},
                                  maxLength: 10,
                                  prefixIcon: const Icon(Icons.phone),
                                  keyboardType: TextInputType.phone,
                                  labelText: "Mobile Number",
                                  onChanged: (value) {}),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                              text: "Register",
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
