import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';

@dao
abstract class HealthRatingDao {
  @Query('SELECT * FROM HealthRating')
  Future<List<HealthRatingEntity>> findAllHealthRating();

  @Query('SELECT * FROM HealthRating WHERE HRowId = :id')
  Future<HealthRatingEntity?> findHealthRatingById(int id);

  @Query('SELECT * FROM HealthRating ORDER BY HRowId DESC LIMIT 1')
  Future<HealthRatingEntity?> findLastHealthRating();

  @insert
  Future<void> insertHealthRating(HealthRatingEntity healthRatingEntity);

  @update
  Future<void> updateHealthRating(HealthRatingEntity healthRatingEntity);

  @delete
  Future<void> deleteHealthRating(HealthRatingEntity healthRatingEntity);

  //mark all as synced
  @Query('UPDATE HealthRating SET hIsSynced = 1')
  Future<void> markAllAsSynced();

  @Query('DELETE FROM HealthRating')
  Future<void> deleteAllHealthRating();
}
