import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/base_reponse_entity.dart';
import '../repositories/auth_repository.dart';

class MobileValidationViaEmail extends UseCase<BaseResponseEntity, MobilevalidationParams> {
  final AuthRepository repository;

  MobileValidationViaEmail({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(MobilevalidationParams params) async {
    return await repository.mobileNumberVerification(
        params.mobileno);
  }
}

class MobilevalidationParams extends Equatable {

  final String mobileno;


  const MobilevalidationParams(
      {required this.mobileno});

  @override
  List<Object?> get props => [ mobileno];
}
