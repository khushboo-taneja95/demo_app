import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tres_connect/core/constants/app_constants.dart';
import 'package:tres_connect/features/main/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:tres_connect/navigation_service.dart';
import 'package:tres_connect/watch_data_listener.dart';
import 'package:workmanager/workmanager.dart';
import 'package:tres_connect/core/bloc/app_bloc_observer.dart';
import 'package:tres_connect/core/bloc/global/global_bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/route_generator.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/custom_theme.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await registerDependncies();
    bool flag = await fetchVitalsInBG();
    return flag;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await registerDependncies();
  bootstrap(() => const App());
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DashboardBloc()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
                title: AppConstants.appName,
                theme: CustomTheme.lightTheme,
                darkTheme: CustomTheme.darkTheme,
                navigatorKey: getIt<NavigationService>().navigatorKey,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: (settings) =>
                    RouteGenerator.generateRoute(settings),
                initialRoute: Routes.login);
          },
        ));
  }
}
