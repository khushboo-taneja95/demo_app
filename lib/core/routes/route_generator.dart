import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/features/auth/presentation/login/pages/login_page.dart';

import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/features/main/presentation/dashboard/pages/dashboard_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    if (kDebugMode) {
      print("PUSHED ${settings.name} WITH ARGS: ${settings.arguments}");
    }
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (ctx) => const LoginPage());

      case Routes.home:
        return MaterialPageRoute(builder: (ctx) => const DashboardPage());

      case Routes.dashboard:
        return MaterialPageRoute(builder: (ctx) => const DashboardPage());

      // case Routes.healthDashboardDetails:
      //   return MaterialPageRoute(builder: (ctx) =>  const HealthDashboardDetailsPage());
      // case Routes.addVaccination:
      //   return MaterialPageRoute(builder: (ctx) => const AddVaccinationPage());

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Unknown route: $name'),
        ),
      );
    });
  }
}
