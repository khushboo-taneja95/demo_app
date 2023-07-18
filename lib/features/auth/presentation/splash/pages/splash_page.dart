import 'package:flutter/material.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/features/auth/presentation/splash/bloc/splash_bloc.dart';
import 'package:tres_connect/features/main/presentation/notification/bloc/notification_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: Scaffold(
        body: SplashBody(
          key: key,
        ),
      ),
    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          Navigator.pushReplacementNamed(context, state.routeName);
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashInitial) {
            BlocProvider.of<SplashBloc>(context).add(SplashInit());
            BlocProvider.of<NotificationBloc>(context)
                .add(const NotificationLoadEvent(fetchFromRemote: false));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                "assets/images/logo_careatwork_splash.png",
                height: 70,
                width: 210,
              ),
            ),
            bottomNavigationBar: Container(
                height: 30,
                child: const Center(
                    child: Text(
                  "5.0",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ))),
          );
        },
      ),
    );
  }
}
