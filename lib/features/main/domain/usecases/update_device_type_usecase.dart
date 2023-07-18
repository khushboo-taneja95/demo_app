import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/main/domain/repositories/main_repository.dart';
import 'package:tres_connect/global_configuration.dart';

class UpdateDeviceTypeUseCase extends UseCase<void, String> {
  final MainRepository repository;

  UpdateDeviceTypeUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    String uid = getIt<GlobalConfiguration>().profile.uID ?? "";
    return repository.updateDeviceType(uid: uid, deviceType: params);
  }
}
