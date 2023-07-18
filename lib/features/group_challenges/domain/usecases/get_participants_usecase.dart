import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/errors/failures.dart';
import '../../../../global_configuration.dart';
import '../../data/models/get_participant_model.dart';
import '../repositories/get_participant_repository.dart';

class GetParticipantsUseCase {
  final ParticipantsRepository repository;

  GetParticipantsUseCase({required this.repository});

  Future<Either<Failure, List<GetParticipants>>> call(
      GetParticipantsParams params) {
    return repository.getParticipants(
      id: params.id,
      pageSize: params.pagesize,
      search: params.search,
    );
  }
}

class GetParticipantsParams extends Equatable {
  final String search;
  final int pagesize;
  final int id;

  const GetParticipantsParams({
    required this.search,
    required this.pagesize,
    required this.id,
  });

  @override
  List<Object?> get props => [search, pagesize, id];
}
