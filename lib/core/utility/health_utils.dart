import 'package:flutter/cupertino.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';

class HealthUtils {
  bool forceRefresh = true;
  healthRating() async {
    List<VaccinationTestEntity> vaccinationCertificate = [];
    List<VaccinationTestEntity> testReports = [];
    List<HealthReading> osVitals = [], btVitals = [];

    final healthRating =
        await getIt<AppDatabase>().healthRatingDao.findLastHealthRating();
    if (healthRating != null) {
      try {
        DateTime healthRatingTime =
            DateTime.parse(healthRating.healthRatingTimeStamp ?? "");
        if (healthRatingTime
            .isAfter(DateTime.now().subtract(const Duration(minutes: 10)))) {
        } else {}
      } catch (e) {
        print(e);
      }
    } else if (forceRefresh == true) {
      HealthRatingEntity healthRatingEntity = HealthRatingEntity();
      getIt<AppDatabase>()
          .healthRatingDao
          .insertHealthRating(healthRatingEntity);
    }
  }

  String prepareRatingJSON(
      List<VaccinationTestEntity> vaccination,
      List<VaccinationTestEntity> testReports,
      List<HealthReading> osVitals,
      List<HealthReading> btVitals) {
    return "";
  }
}
