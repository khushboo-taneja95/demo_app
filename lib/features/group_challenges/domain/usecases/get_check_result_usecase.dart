import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_check_result_model.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/get_participant_repository.dart';

class GetCheckResultUseCase {
  final ParticipantsRepository repository;
  GetCheckResultUseCase({required this.repository});

  Future<Either<Failure, CheckResult>> call(GetCheckResultParams params) {
    return repository.checkResult(
        uid: params.uid, challengeid: params.challengeid);
  }
}

class GetCheckResultParams extends Equatable {
  final String uid;
  final int challengeid;

  const GetCheckResultParams({required this.uid, required this.challengeid});

  @override
  List<Object?> get props => [uid, challengeid];
}
