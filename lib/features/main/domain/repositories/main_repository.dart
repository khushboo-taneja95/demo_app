import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';

abstract class MainRepository {
  Future<Either<Failure, List<NotificationEntity>>> getRemoteNotifications(
      {required String uid});
  Future<Either<Failure, List<NotificationEntity>>> getLocalNotifications();
  Future<Either<Failure, NotificationEntity?>> getLocalNotification(
      {required String notificationId});
  Future<Either<Failure, bool>> markNotificationAsRead(
      {required String notificationId});
  Future<Either<Failure, bool>> markAllNotificationsAsRead();
  Future<Either<Failure, void>> updateDeviceType(
      {required String uid, required String deviceType});
}
