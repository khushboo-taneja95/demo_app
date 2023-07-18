import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/main/domain/repositories/main_repository.dart';

class MarkNotificationReadUseCase extends UseCase<bool,String?> {
  final MainRepository repository;

  MarkNotificationReadUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String? id) async {
    if(id == null){
      return await repository.markAllNotificationsAsRead();
    }else {
      return await repository.markNotificationAsRead(notificationId: id);
    }
  }
}
