import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/get_all_badges_model.dart';
import '../repositories/get_participant_repository.dart';

class GetAllBadgesUseCase {
  final ParticipantsRepository repository;
  GetAllBadgesUseCase({required this.repository});

  Future<Either<Failure, List<GetAllBadgeByUserId>>> call(
      GetAllBadgesParams params) {
    return repository.getAllBadgeByUserId(
        uid: params.uid,
        pageSize: params.pageSize,
        startIndex: params.startIndex,
        challengeid: params.challengeid);
  }
}

class GetAllBadgesParams extends Equatable {
  final String uid;
  final int pageSize;
  final int startIndex;
  final int challengeid;

  const GetAllBadgesParams(
      {required this.uid,
      required this.pageSize,
      required this.startIndex,
      required this.challengeid});

  @override
  List<Object?> get props => [uid, pageSize, startIndex, challengeid];
}
