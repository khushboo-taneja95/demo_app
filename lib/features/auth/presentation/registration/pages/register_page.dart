import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/features/auth/presentation/registration/bloc/register_bloc.dart';
import 'package:tres_connect/widgets/my_dialog.dart';
import 'package:tres_connect/widgets/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterBody(
        key: key,
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterBody> {
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Palette.primaryColor,
          ));
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
        } else if (state is RegisterLoading) {
          Utils.showLoaderDialog(context);
        } else if (state is RegisterFailure) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) => BasicDialog(
                    title: "Registration Failed",
                    description: state.message,
                  ));
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
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
                              height: 30,
                            ),
                            const Text("Register",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MyTextField(
                                      labelText: "Full Name",
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid name";
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(Icons.person),
                                      controller: _nameController,
                                      onChanged: (text) {}),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                      labelText: "Email Address",
                                      validator: (value) =>
                                          Utils.validateEmail(value),
                                      prefixIcon: Icon(Icons.mail),
                                      controller: _emailController,
                                      onChanged: (text) {}),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                      labelText: "Password",
                                      validator: (value) {
                                        if (value == null || value.length < 8) {
                                          return "Password should at least be 8 characters long";
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(Icons.key),
                                      controller: _passwordController,
                                      isPasswordField: true,
                                      onChanged: (text) {}),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        Utils.hideKeyboard();
                                        context.read<RegisterBloc>().add(
                                            RegisterBtnClicked(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text));
                                        // Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: Palette.greenbtn,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Register',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state is RegisterLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const SizedBox(),
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
