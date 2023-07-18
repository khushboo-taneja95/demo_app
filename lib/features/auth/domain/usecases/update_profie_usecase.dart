import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase
    extends UseCase<BaseResponseEntity, UserProfileEntiry> {
  final AuthRepository repository;

  UpdateProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(
      UserProfileEntiry params) async {
    return await repository.updateProfile(params);
  }
}
