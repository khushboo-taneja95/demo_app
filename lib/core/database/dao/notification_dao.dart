import 'package:floor/floor.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';

@dao
abstract class NotificationDao {
  @Query('SELECT * FROM NotificationMessageTable ORDER BY NotificationId DESC')
  Future<List<NotificationEntity>> getNotifications();

  @Query('SELECT * FROM NotificationMessageTable WHERE NotificationId = :id')
  Future<NotificationEntity?> getNotification(String id);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertNotification(NotificationEntity notificationEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNotifications(List<NotificationEntity> notificationEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNotification(NotificationEntity notificationEntity);

  //Get unread notification count
  @Query('SELECT COUNT(*) FROM NotificationMessageTable WHERE IsSeen = 0')
  Future<int?> getUnreadNotificationCount();

  //mark all notifications as read
  @Query('UPDATE NotificationMessageTable SET IsSeen = 1')
  Future<void> markAllNotificationsAsRead();

  //mark one notification as read
  @Query(
      'UPDATE NotificationMessageTable SET IsSeen = 1 WHERE NotificationId = :notificationId')
  Future<void> markNotificationAsRead(String notificationId);

  @Query('DELETE FROM NotificationMessageTable')
  Future<void> deleteAllNotifications();
}
