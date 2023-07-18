import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/liked_list_model.dart';
import '../repositories/get_participant_repository.dart';

class LikedListUseCase {
  final ParticipantsRepository repository;
  LikedListUseCase({required this.repository});

  Future<Either<Failure, List<ListOfLikesChallenge>>> call(
      GetLikedListParams params) {
    return repository.listOfLikesChallenge(
        uid: params.uid,
        pageSize: params.pageSize,
        startIndex: params.startIndex,
        challengeid: params.challengeid);
  }
}

class GetLikedListParams extends Equatable {
  final String uid;
  final int pageSize;
  final int startIndex;
  final int challengeid;

  const GetLikedListParams(
      {required this.uid,
      required this.pageSize,
      required this.startIndex,
      required this.challengeid});

  @override
  List<Object?> get props => [uid, pageSize, startIndex, challengeid];
}
