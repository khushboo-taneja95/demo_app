import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';

class LogoutUserUseCase extends UseCase<void, NoParams> {
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    await FirebaseAuth.instance.signOut();

    await getIt<AppDatabase>().userProfileDao.deleteUserProfile();
    await getIt<AppDatabase>().healthReadingDao.deleteAll();
    await getIt<AppDatabase>().healthRatingDao.deleteAllHealthRating();
    await getIt<AppDatabase>().activityDetailsDao.deleteAll();
    await getIt<AppDatabase>().activitySummaryDao.deleteAll();
    await getIt<AppDatabase>().vaccinationtTestDao.deleteAllVaccinationTest();
    await getIt<AppDatabase>().travelHistoryDao.deleteAllTravelHistory();

    // await getIt<SharedPreferences>().remove("uid");
    // await getIt<SharedPreferences>().remove("access_token");
    // await getIt<SharedPreferences>().remove("expires_in");
    // await getIt<SharedPreferences>().remove("refresh_token");
    // await getIt<SharedPreferences>().remove("device_name");
    // await getIt<SharedPreferences>().remove("device_address");
    await getIt<SharedPreferences>().clear();
    await FirebaseAuth.instance.signOut();
    return const Right(null);
  }
}
