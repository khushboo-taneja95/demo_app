import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/domain/repositories/create_challenge_repository.dart';

class GetAllBadgesUseCase
    extends UseCase<List<GetAllBadge>, GetAllBadgesParams> {
  final CreateChallengeRepository repository;

  GetAllBadgesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<GetAllBadge>>> call(GetAllBadgesParams params) {
    return repository.getAllBadge(Rank: params.Rank.toString());
  }
}

class GetAllBadgesParams extends Equatable {
  final int Rank;

  const GetAllBadgesParams({
    required this.Rank,
  });

  @override
  List<Object?> get props => [Rank];
}
