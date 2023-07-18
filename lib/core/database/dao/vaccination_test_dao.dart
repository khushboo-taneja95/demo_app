import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';

@dao
abstract class VaccinationTestDao {
  @Query('SELECT * FROM VaccinationTest')
  Future<List<VaccinationTestEntity>> findAllVaccinationTest();

  @Query(
      'SELECT * FROM VaccinationTest WHERE vaccinationType = :vaccinationType')
  Future<List<VaccinationTestEntity>> findAllByType(String vaccinationType);

  //Fetch vaccination  of last 14 days
  @Query(
      'SELECT * FROM VaccinationTest WHERE diseaseCode = :diseaseCode AND vaccinationType = :vaccinationType AND vaccinationDate BETWEEN :startDate AND :endDate')
  Future<List<VaccinationTestEntity>> findAllByDateTypeAndDisease(
      String diseaseCode,
      String vaccinationType,
      String startDate,
      String endDate);

  @Query(
      'SELECT * FROM VaccinationTest WHERE vaccinationName = :vaccinationName AND vaccinationDate BETWEEN :startDate AND :endDate')
  Future<List<VaccinationTestEntity>> findAllByName(
      String vaccinationName, String startDate, String endDate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity);

  @insert
  Future<void> insertVaccinationTestList(
      List<VaccinationTestEntity> vaccinationTestEntityList);

  @update
  Future<void> updateVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity);

  @delete
  Future<void> deleteVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity);

  @Query('DELETE FROM VaccinationTest')
  Future<void> deleteAllVaccinationTest();
}
