import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/data/models/qr_code_response.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class GetQRCodeUseCase extends UseCase<QRCodeResponse, GetQRCodeUseCaseParams> {
  final AuthRepository repository;

  GetQRCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, QRCodeResponse>> call(
      GetQRCodeUseCaseParams params) async {
    return await repository.getQRCode(name: params.name, uid: params.uid);
  }
}

class GetQRCodeUseCaseParams extends Equatable {
  final String name;
  final String uid;

  const GetQRCodeUseCaseParams({required this.name, required this.uid});

  @override
  List<Object?> get props => [name, uid];
}
