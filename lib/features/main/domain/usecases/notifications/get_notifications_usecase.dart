import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/main/domain/repositories/main_repository.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';

class GetNotificationsUseCase extends UseCase<List<NotificationEntity>, NotificationParams> {
  final MainRepository repository;

  GetNotificationsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NotificationParams params) async {
    if(params.fetchFromRemote) {
      return await repository.getRemoteNotifications(uid: params.uid);
    }else{
      return await repository.getLocalNotifications();
    }
  }
}

class NotificationParams {
  final String uid;
  final bool fetchFromRemote;

  NotificationParams({required this.uid, this.fetchFromRemote = false});
}