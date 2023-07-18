import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/health_reading_entity.dart';

@dao
abstract class HealthReadingsDao {
  @Query('SELECT * FROM HealthReadings ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getAllReadings();

  @Query('SELECT * FROM HealthReadings ORDER BY TimeStamp DESC LIMIT 1')
  Stream<HealthReading?> listenLastHealthReading();

  @Query(
      'SELECT * FROM HealthReadings WHERE MedicalCode = :medicalCode AND TimeStamp BETWEEN :startDate AND :endDate ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getReadingsBetween(
      String startDate, String endDate, String medicalCode);

  @Query(
      'SELECT * FROM HealthReadings WHERE MedicalCode = :medicalCode AND Date = :date ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getReadingsForDate(
      String date, String medicalCode);

  @Query(
      'SELECT * FROM HealthReadings WHERE IsSynced = 0 ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getUnSynchedReadings();

  @Query('SELECT * FROM HealthReadings WHERE IsGoogleFitSync = 0 ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getUnSynchedReadingsForHealth();

  @Query(
      'SELECT * FROM HealthReadings WHERE MedicalCode = :medicalCode AND IsSynced = 0 ORDER BY TimeStamp ASC')
  Future<List<HealthReading>> getReadingsToUpload(String medicalCode);

  @Query('UPDATE HealthReadings SET IsSynced = 1')
  Future<void> markAllReadingsAsSynced();

  @Query(
      'SELECT * FROM HealthReadings WHERE MedicalCode = :medicalCode ORDER BY TimeStamp DESC LIMIT 1')
  Future<HealthReading?> getLastReading(String medicalCode);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertAllReadings(List<HealthReading> readings);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertReading(HealthReading reading);

  @Query('DELETE FROM HealthReadings')
  Future<void> deleteAll();
}
