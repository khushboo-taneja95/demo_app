import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/auth/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:tres_connect/widgets/my_dialog.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: const Scaffold(
        body: WelcomeBody(),
      ),
    );
  }
}

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var presscount = 0;
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state is WelcomeSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.dashboard, (route) => false);
        } else if (state is WelcomeLoading) {
          Utils.showLoaderDialog(context, isDismissible: false);
        } else if (state is WelcomeFailure) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) => BasicDialog(
                    title: "Login Failed",
                    description: state.message,
                  ));
        }
      },
      child: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                presscount++;
                if (presscount == 2) {
                  exit(0);
                } else {
                  var snackBar = const SnackBar(
                      content: Text('Press back again to exit the app'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return false;
                }
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/logo_careatwork_splash.png",
                                  height: 80,
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text("Get Started with",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<WelcomeBloc>()
                                        .add(LoginWithGoogleBtnClicked());
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/googlelogo.png",
                                          height: 40,
                                          width: 40,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Google',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<WelcomeBloc>()
                                        .add(LoginWithFacebookBtnClicked());
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Palette.fecebookbtn),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/facebookicon.png",
                                          height: 30,
                                          width: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Facebook',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (getIt<SharedPreferences>()
                                            .getBool('is_first') ==
                                        true) {
                                      Navigator.pushNamed(
                                          context, Routes.signup);
                                    } else {
                                      Navigator.pushNamed(
                                          context, Routes.login);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: const BoxDecoration(
                                        color: Palette.greenbtn,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getIt<SharedPreferences>()
                                                      .getBool('is_first') ==
                                                  true
                                              ? 'Register with Email'
                                              : 'Login with Email',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // InkWell(
                                //   onTap: () {
                                //     context
                                //         .read<WelcomeBloc>()
                                //         .add(LoginWithAppleBtnClicked());
                                //   },
                                //   child: Container(
                                //     height: 50,
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 15.0),
                                //     padding: const EdgeInsets.all(3.0),
                                //     decoration: BoxDecoration(
                                //         border: Border.all(color: Colors.grey),
                                //         borderRadius: const BorderRadius.all(
                                //             Radius.circular(10))),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Image.asset(
                                //           "assets/images/apple_icon.png",
                                //           height: 30,
                                //           width: 30,
                                //         ),
                                //         const SizedBox(
                                //           width: 10,
                                //         ),
                                //         const Text(
                                //           'Sign in with Apple',
                                //           style: TextStyle(
                                //               fontSize: 18,
                                //               color: Colors.black),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          if (getIt<SharedPreferences>().getBool('is_first') ==
                              true) {
                            Navigator.pushNamed(context, Routes.login);
                          } else {
                            Navigator.pushNamed(context, Routes.signup);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          height: 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(
                              children: [
                                Container(
                                  height: 1,
                                  color: Palette.lineGrey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    Text(
                                      getIt<SharedPreferences>()
                                                  .getBool('is_first') ==
                                              true
                                          ? "Sign In"
                                          : "Register",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Palette.secondaryColor1),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
