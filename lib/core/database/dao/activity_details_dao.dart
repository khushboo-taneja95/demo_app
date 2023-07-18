import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/activity_detail_entity.dart';

@dao
abstract class ActivityDetailsDao {
  @Query('SELECT * FROM ActivityDetails ORDER BY ActivityStartDate ASC')
  Future<List<ActivityDetails>> getAllActivityDetails();

  @Query(
      'SELECT * FROM ActivityDetails WHERE ActivityType = :activityType AND ActivityStartDate BETWEEN :startDate AND :endDate ORDER BY ActivityStartDate ASC')
  Future<List<ActivityDetails>> getActivityDetailsBetween(
      DateTime startDate, DateTime endDate, String activityType);

  @Query(
      "SELECT RowID,UID,ActivityType,ActivityStartDate,ActivityEndDate,DeviceType,IsAutomatedReading,IsSynced,IsGoogleFitSync, strftime(:wildcard,date) as date, sum(ActivityValue) as ActivityValue,((ActivityEndDate - ActivityStartDate)/1000) as ActivityTotalSleep FROM ActivityDetails WHERE ActivityType = :activityType AND date BETWEEN :startDate AND :endDate GROUP BY strftime(:wildcard,date)")
  Future<List<ActivityDetails>> getDetailsBetween(
      String wildcard, String startDate, String endDate, String activityType);

  @Query(
      'SELECT * FROM ActivityDetails WHERE date(ActivityStartDate) = date(:date) AND ActivityType = :activityType ORDER BY ActivityStartDate ASC')
  Future<List<ActivityDetails>> getActivityDetailsForDate(
      DateTime date, String activityType);

  @Query(
      'SELECT * FROM ActivityDetails WHERE ActivityType = :activityType AND IsSynced = 0 ORDER BY ActivityStartDate ASC')
  Future<List<ActivityDetails>> getDetailsToUpload(String activityType);

  @Query(
      'SELECT * FROM ActivityDetails WHERE ActivityType = :activityType ORDER BY ActivityStartDate DESC')
  Future<ActivityDetails?> getLastDetails(String activityType);

  @Query('UPDATE ActivityDetails SET IsSynced = 1')
  Future<void> markAllAsSynced();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllDetails(List<ActivityDetails> allDetails);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDetails(ActivityDetails details);

  @Query('DELETE FROM ActivityDetails')
  Future<void> deleteAll();

  @Query(
      'SELECT * FROM ActivityDetails WHERE IsGoogleFitSync = 0 ORDER BY ActivityStartDate ASC')
  Future<List<ActivityDetails>> getUnSynchedActivityForHealth();
}
