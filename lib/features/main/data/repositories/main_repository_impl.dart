import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/main/data/datasources/local_data_source.dart';
import 'package:tres_connect/features/main/data/datasources/remote_data_source.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/features/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource remoteDataSource = MainRemoteDataSourceImpl();
  final MainLocalDataSource localDataSource = MainLocalDataSourceImpl();

  MainRepositoryImpl();

  @override
  Future<Either<Failure, NotificationEntity?>> getLocalNotification(
      {required String notificationId}) async {
    try {
      final notification =
          await localDataSource.getNotification(notificationId: notificationId);
      return Right(notification);
    } on Exception catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>>
      getLocalNotifications() async {
    try {
      return Right(await localDataSource.getNotifications());
    } on Exception catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getRemoteNotifications(
      {required String uid}) async {
    try {
      final data = await remoteDataSource.getNotifications(uid: uid);
      if (data.errorMessage != null) {
        return Left(ServerFailure(data.errorMessage!));
      } else {
        try {
          localDataSource.saveNotifications(data.notificationList!);
        } on Exception catch (e) {
          //ignore the exception occurred while saving to local database if the data is already there
        }
        final notifications = await localDataSource.getNotifications();
        return Right(notifications);
      }
    } on Exception catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markAllNotificationsAsRead() async {
    try {
      final data = await localDataSource.markAllNotificationsAsRead();
      return Right(data);
    } on Exception catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markNotificationAsRead(
      {required String notificationId}) async {
    try {
      final data = await localDataSource.markNotificationAsRead(
          notificationId: notificationId);
      return Right(data);
    } on Exception catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDeviceType(
      {required String uid, required String deviceType}) async {
    try {
      final data = await remoteDataSource.updateDeviceType(
          uid: uid, deviceType: deviceType);
      return Right(data);
    } on Exception catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }
}
