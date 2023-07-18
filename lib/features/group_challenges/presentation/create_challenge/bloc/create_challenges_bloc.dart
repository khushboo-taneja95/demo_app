import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/create_challenges_usecase.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_all_badges_usescases.dart';
part 'create_challenges_event.dart';
part 'create_challenges_state.dart';

class CreateChallengeBloc
    extends Bloc<CreateChallengeEvent, CreateChallengeState> {
  CreateChallengeBloc() : super(CreateChallengeInitial()) {
    on<CreateChallengeClicked>(_createChallenges);
    on<CreateChallengeLoadEvent>(_getAllBadges);
  }

  _createChallenges(
      CreateChallengeClicked event, Emitter<CreateChallengeState> emit) async {
    emit(const CreateChallengeLoading());
    if (event != null) {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/img.jpg');
      final challengeResp = await CreateChallengesUseCase(repository: getIt())
          .call(CreateChallengesParams(
        challengeType: event.challengeType,
        challengeDetails: event.challengeDetails,
        challengeEndDate: event.challengeEndDate,
        challengeImage: event.challengeImage,
        challengeStartDate: event.challengeStartDate,
        challengeTarget: event.challengeTarget,
        challengeTitle: event.challengeTitle,
        createdBy: event.createdBy,
        creationDate: event.creationDate,
        badge_completion: event.badge_completion,
        badge_one: event.badge_one,
        badge_three: event.badge_three,
        badge_two: event.badge_two,
        group_name: event.group_name,
        group_uid: event.group_uid,
      ));
      challengeResp.fold((l) {
        emit(CreateChallengeError(message: l.message));
      }, (r) {
        emit(CreateChallengesLoaded(
          challengeType: event.challengeType,
          challengeDetails: event.challengeDetails,
          challengeEndDate: event.challengeEndDate,
          challengeImage: event.challengeImage,
          challengeStartDate: event.challengeStartDate,
          challengeTarget: event.challengeTarget,
          challengeTitle: event.challengeTitle,
          createdBy: event.createdBy,
          creationDate: event.creationDate,
          badge_completion: event.badge_completion,
          badge_one: event.badge_one,
          badge_three: event.badge_three,
          badge_two: event.badge_two,
          group_name: event.group_name,
          group_uid: event.group_uid,
        ));
      });
    } else {
      emit(CreateChallengesLoaded(
        challengeType: event.challengeType,
        challengeDetails: event.challengeDetails,
        challengeEndDate: event.challengeEndDate,
        challengeImage: event.challengeImage,
        challengeStartDate: event.challengeStartDate,
        challengeTarget: event.challengeTarget,
        challengeTitle: event.challengeTitle,
        createdBy: event.createdBy,
        creationDate: event.creationDate,
        badge_completion: event.badge_completion,
        badge_one: event.badge_one,
        badge_three: event.badge_three,
        badge_two: event.badge_two,
        group_name: event.group_name,
        group_uid: event.group_uid,
      ));
    }
  }

  void _getAllBadges(CreateChallengeLoadEvent event,
      Emitter<CreateChallengeState> emit) async {
    emit(const CreateChallengeLoading());
    try {
      final challengesResp = await GetAllBadgesUseCase(repository: getIt())
          .call(GetAllBadgesParams(Rank: event.forRank));
      challengesResp.fold((l) => emit(CreateChallengeError(message: l.message)),
          (r) => emit(GetBadgesLoaded(getAllBadge: r)));
    } catch (e) {
      emit(CreateChallengeError(message: e.toString()));
    }
  }
}
