import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class GetUserProfileUseCase extends UseCase<UserProfileEntiry, String> {
  final AuthRepository repository;

  GetUserProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, UserProfileEntiry>> call(String params) async {
    return await repository.getProfile(params);
  }
}
