import 'package:flutter/material.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/features/auth/presentation/forgotpassword/bloc/forgotpassword_bloc.dart';
import 'package:tres_connect/widgets/my_text_field.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/widgets/tres_btn.dart';
import 'package:tres_connect/core/utility/utils.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotpasswordBloc(),
      child: Scaffold(
        body: ForgotPasswordBody(),
      ),
    );
  }
}

class ForgotPasswordBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotpasswordBloc, ForgotpasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.pop(context);
          Utils.showSnackBar(context, state.message);
          Navigator.pushNamed(context, Routes.login);
        }
        if (state is ForgotPasswordLoading) {
          Utils.showLoaderDialog(context);
        }
      },
      child: BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
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
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo_careatwork_splash.png",
                          height: 100,
                          width: 200,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Forgot Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(
                          height: 25,
                        ),
                        Form(
                          key: _formKey,
                          child: MyTextField(
                              labelText: "Email Address",
                              validator: (value) {
                                return Utils.validateEmail(value);
                              },
                              prefixIcon: const Icon(Icons.mail),
                              controller: emailController,
                              onChanged: (text) {}),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                          text: "Submit",
                          bgColor: Palette.greenbtn,
                          onClick: () {
                            //  Navigator.pushNamed(context, Routes.home);
                            if (_formKey.currentState?.validate() == true) {
                              Utils.hideKeyboard();
                              context.read<ForgotpasswordBloc>().add(
                                  ForgotPasswordBtnClicked(
                                      Emailid: emailController.text.trim()));
                            }
                            // else Utils.showSnackBar(context, "Enter Registered Email Id");
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Routes.login);
                          },
                          child: const Text("Back to Sign In",
                              style: TextStyle(
                                  color: Palette.secondaryColor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
