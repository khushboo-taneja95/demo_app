import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/like_unlike_model.dart';
import '../repositories/get_participant_repository.dart';

class LikeUnlikeUseCase {
  final ParticipantsRepository repository;

  LikeUnlikeUseCase({required this.repository});

  Future<Either<Failure, LikeUnlikeModel>> call(CreateLikeUnlikeParams params) {
    return repository.likeUnlike(
      challengeid: params.challengeid,
      participant_uid: params.participant_uid,
      reacted_by: params.reacted_by,
      reaction: params.reaction,
    );
  }
}

class CreateLikeUnlikeParams extends Equatable {
  final String challengeid;
  final String participant_uid;
  final String reacted_by;
  final String reaction;

  const CreateLikeUnlikeParams({
    required this.challengeid,
    required this.participant_uid,
    required this.reacted_by,
    required this.reaction,
  });

  @override
  List<Object?> get props =>
      [challengeid, participant_uid, reacted_by, reaction];
}
