import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class RegisterViaEmail extends UseCase<BaseResponseEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterViaEmail({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(RegisterParams params) async {
    return await repository.registerViaEmail(
        params.name, params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterParams(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}
