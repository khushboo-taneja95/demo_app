import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';
import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';

class LoginViaEmail extends UseCase<AuthResponseEntity, LoginParams> {
  final AuthRepository repository;

  LoginViaEmail({required this.repository});

  @override
  Future<Either<Failure, AuthResponseEntity>> call(LoginParams params) async {
    return await repository.loginViaEmail(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  String email;
  String password;

  LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
