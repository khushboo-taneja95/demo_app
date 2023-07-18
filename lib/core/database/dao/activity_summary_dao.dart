import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/activity_summary_entity.dart';

@dao
abstract class ActivitySummaryDao {
  @Query('SELECT * FROM ActivitySummary ORDER BY ActivityDate ASC')
  Future<List<ActivitySummary>> getAllSummary();

  @Query(
      'SELECT * FROM ActivitySummary WHERE ActivityType = :activityType AND ActivityDate BETWEEN :startDate AND :endDate ORDER BY ActivityDate ASC')
  Future<List<ActivitySummary>> getSummaryBetween(
      DateTime startDate, DateTime endDate, String activityType);

  @Query(
      'SELECT * FROM ActivitySummary WHERE ActivityDate = :date ORDER BY ActivityDate ASC')
  Future<List<ActivitySummary>> getSummaryForDate(DateTime date);

  @Query(
      'SELECT * FROM ActivitySummary WHERE ActivityType = :activityType ORDER BY ActivityDate DESC LIMIT 1')
  Future<ActivitySummary?> getLastSummary(String activityType);

  @Query(
      'SELECT * FROM ActivitySummary WHERE ActivityType = :activityType AND IsSynced = 0 ORDER BY ActivityDate ASC')
  Future<List<ActivitySummary>> getSummaryToUpload(String activityType);

  @Query('UPDATE ActivitySummary SET IsSynced = 1')
  Future<void> markAllReadingsAsSynced();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllSummary(List<ActivitySummary> readings);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSummary(ActivitySummary reading);

  @Query('DELETE FROM ActivitySummary')
  Future<void> deleteAll();
}
