import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/main/data/models/notifications_model.dart';

abstract class MainLocalDataSource {
  Future<List<NotificationList>> getNotifications();
  Future<NotificationList?> getNotification({required String notificationId});
  Future<bool> markNotificationAsRead({required String notificationId});
  Future<bool> markAllNotificationsAsRead();
  Future<bool> saveNotifications(List<NotificationList> notifications);
}

class MainLocalDataSourceImpl extends MainLocalDataSource {
  final AppDatabase database = getIt<AppDatabase>();
  final SharedPreferences sharedPreferences = getIt<SharedPreferences>();

  MainLocalDataSourceImpl();

  @override
  Future<List<NotificationList>> getNotifications() async {
    final notificationEntity =
        await database.notificationDao.getNotifications();
    return notificationEntity
        .map((e) => NotificationList.fromEntity(e))
        .toList();
  }

  @override
  Future<NotificationList?> getNotification(
      {required String notificationId}) async {
    final notificationEntry =
        await database.notificationDao.getNotification(notificationId);
    if (notificationEntry == null) throw Exception("Notification not found");
    return NotificationList.fromEntity(notificationEntry);
  }

  @override
  Future<bool> markAllNotificationsAsRead() async {
    await database.notificationDao.markAllNotificationsAsRead();
    return true;
  }

  @override
  Future<bool> markNotificationAsRead({required String notificationId}) async {
    await database.notificationDao.markNotificationAsRead(notificationId);
    return true;
  }

  @override
  Future<bool> saveNotifications(List<NotificationList> notifications) async {
    try {
      for (var item in notifications) {
        await database.notificationDao.insertNotification(item);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
