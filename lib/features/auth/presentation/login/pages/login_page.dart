import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/widgets/my_text_field.dart';
import 'package:tres_connect/widgets/tres_btn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController(
  //     text: "sujeet.kumar@quadlabs.com"); //anubhavanand884@gmail.com
  // TextEditingController passwordController =
  //     TextEditingController(text: "Sujeet@100"); //#123Quadlabs

  TextEditingController emailController = TextEditingController(
      text: "anubhavanand884@gmail.com"); //anubhavanand884@gmail.com
  TextEditingController passwordController =
      TextEditingController(text: "#123Quadlabs"); //#123Quadlabs

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          //are you sure you want to download the data again?
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Do you want to sync your data?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            getIt<SharedPreferences>()
                                .setBool("sync_data_from_server", false);
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, state.routeName, (_) => false,
                                arguments: state.arguments);
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            //DownloadAllData().call(NoParams());
                            print(state.arguments);
                            getIt<SharedPreferences>()
                                .setBool("sync_data_from_server", true);
                            Navigator.pushNamedAndRemoveUntil(
                                context, state.routeName, (_) => false,
                                arguments: state.arguments);
                          },
                          child: const Text("Yes")),
                    ],
                  ));
        } else if (state is LoginLoading) {
          Utils.showLoaderDialog(context);
        } else if (state is LoginFailure) {
          Navigator.pop(context);
          Utils.showSnackBar(context, state.message);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/logo_careatwork_splash.png",
                                height: 80,
                                width: 150,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("Sign in with Email",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                height: 30,
                              ),
                              MyTextField(
                                  labelText: "Email Address",
                                  prefixIcon: const Icon(Icons.mail),
                                  controller: emailController,
                                  onChanged: (text) {}),
                              const SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.key),
                                  controller: passwordController,
                                  isPasswordField: true,
                                  onChanged: (text) {}),
                              const SizedBox(
                                height: 20,
                              ),
                              MyButton(
                                text: "Sign In",
                                bgColor: Palette.greenbtn,
                                onClick: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    Utils.hideKeyboard();
                                    context.read<LoginBloc>().add(
                                        LoginBtnClicked(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim()));
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.forgetPass);
                                },
                                child: const Text("Forgot Password?",
                                    style: TextStyle(
                                        color: Palette.secondaryColor1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 1,
                                          color: Palette.lineGrey,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Don't have an account? ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Register here",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      Palette.secondaryColor1),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
