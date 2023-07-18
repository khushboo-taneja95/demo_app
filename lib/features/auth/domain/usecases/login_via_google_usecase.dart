import 'package:dartz/dartz.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class LoginViaGoogle extends UseCase<AuthResponseEntity, NoParams> {
  final AuthRepository repository;

  LoginViaGoogle({required this.repository});

  @override
  Future<Either<Failure, AuthResponseEntity>> call(NoParams params) async {
    return await repository.loginWithGoogle();
  }
}
