import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/converters/datetime_converter.dart';
import 'package:tres_connect/core/database/dao/activity_details_dao.dart';
import 'package:tres_connect/core/database/dao/activity_summary_dao.dart';
import 'package:tres_connect/core/database/dao/health_rating_dao.dart';
import 'package:tres_connect/core/database/dao/health_readings_dao.dart';
import 'package:tres_connect/core/database/dao/travel_history_dao.dart';
import 'package:tres_connect/core/database/dao/user_profile_info_dao.dart';
import 'package:tres_connect/core/database/dao/vaccination_test_dao.dart';
import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tres_connect/core/database/entity/travel_history_entity.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/core/database/dao/notification_dao.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  HealthReading,
  HealthRatingEntity,
  ActivityDetails,
  ActivitySummary,
  UserProfileEntiry,
  NotificationEntity,
  TravelHistoryEntity,
  VaccinationTestEntity,
  // HealthRatingEntity,
  //ECGReportEntity
])
abstract class AppDatabase extends FloorDatabase {
  HealthReadingsDao get healthReadingDao;
  HealthRatingDao get healthRatingDao;
  ActivitySummaryDao get activitySummaryDao;
  ActivityDetailsDao get activityDetailsDao;
  UserProfileInfoDao get userProfileDao;
  NotificationDao get notificationDao;
  VaccinationTestDao get vaccinationtTestDao;
  TravelHistoryDao get travelHistoryDao;
}
