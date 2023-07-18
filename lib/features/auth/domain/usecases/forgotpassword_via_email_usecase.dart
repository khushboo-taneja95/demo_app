import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordViaEmail extends UseCase<BaseResponseEntity, forgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordViaEmail({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(forgotPasswordParams params) async {
    return await repository.forgotPassword(
      params.Emailid);
  }
}

class forgotPasswordParams extends Equatable {

  final String Emailid;


  const forgotPasswordParams(
      {required this.Emailid});

  @override
  List<Object?> get props => [ Emailid];
}
