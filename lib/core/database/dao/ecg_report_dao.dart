
import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/ecg_report_entity.dart';

abstract class ECGReportDao{
  @Query('SELECT * FROM ECGReport')
  Future<List<ECGReportEntity>> findAllECGReport();

  @Query('SELECT * FROM ECGReport WHERE ECGTransId = :id')
  Future<ECGReportEntity> findECGReportById(int id);

  @insert
  Future<void> insertECGReport(ECGReportEntity eCGReportEntity);

  @update
  Future<void> updateECGReport(ECGReportEntity eCGReportEntity);

  @delete
  Future<void> deleteECGReport(ECGReportEntity eCGReportEntity);

  @Query('DELETE FROM ECGReport')
  Future<void> deleteAllECGReport();
}