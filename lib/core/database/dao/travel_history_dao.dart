import 'package:floor/floor.dart';
import 'package:tres_connect/core/database/entity/travel_history_entity.dart';

@dao
abstract class TravelHistoryDao {
  @Query('SELECT * FROM TravelHistory')
  Future<List<TravelHistoryEntity>> findAllTravelHistory();

  @Query('SELECT * FROM TravelHistory WHERE RowID = :id')
  Future<TravelHistoryEntity?> findTravelHistoryById(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertTravelHistory(TravelHistoryEntity travelHistoryEntity);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertTravelHistories(
      List<TravelHistoryEntity> travelHistoryEntity);

  @update
  Future<void> updateTravelHistory(TravelHistoryEntity travelHistoryEntity);

  @delete
  Future<void> deleteTravelHistory(TravelHistoryEntity travelHistoryEntity);

  @Query('DELETE FROM TravelHistory')
  Future<void> deleteAllTravelHistory();
}
