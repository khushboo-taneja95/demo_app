import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/networking/api.dart';
import 'package:tres_connect/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

import 'package:tres_connect/features/main/data/repositories/main_repository_impl.dart';
import 'package:tres_connect/features/main/domain/repositories/main_repository.dart';

import 'package:tres_connect/navigation_service.dart';

import 'package:tres_connect/core/database/database.dart';

final getIt = GetIt.instance;

Future<void> registerDependncies() async {
  // getIt.registerSingleton<WatchSdk>(WatchSdk());

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerLazySingleton<AppDatabase>(() => database);

  getIt.registerLazySingleton(() => NavigationService());

  //UserDetails

  //api
  getIt.registerLazySingleton<Dio>(() => Api.createDio());

  //repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );
  getIt.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(),
  );
}
