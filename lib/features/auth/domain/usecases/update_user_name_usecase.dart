
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/base_reponse_entity.dart';
import '../repositories/auth_repository.dart';

class UpdateUserName extends UseCase<BaseResponseEntity, UpdateUserNameParams> {
  final AuthRepository repository;

  UpdateUserName({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity>> call(UpdateUserNameParams params) async {
    return await repository.updateUserName(params.uid,params.username,
        params.mobileno);
  }
}

class UpdateUserNameParams extends Equatable {

  final String uid;
  final String username;
  final String mobileno;


  const UpdateUserNameParams(
      {required this.uid, required this.username,required this.mobileno});

  @override
  List<Object?> get props => [ mobileno];
}
