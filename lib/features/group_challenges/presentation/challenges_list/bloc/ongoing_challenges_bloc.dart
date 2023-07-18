import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_challenges_usecase.dart';
import 'package:tres_connect/global_configuration.dart';
part 'ongoing_challenges_event.dart';
part 'ongoing_challenges_state.dart';

class OnGoingChallengeBloc
    extends Bloc<OnGoingChallengeEvent, OnGoingChallengeState> {
  OnGoingChallengeBloc() : super(OnGoingChallengeLoading()) {
    on<OnGoingChallengeLoadEvent>(_loadChallenges);
  }

  void _loadChallenges(OnGoingChallengeLoadEvent event,
      Emitter<OnGoingChallengeState> emit) async {
    emit(OnGoingChallengeLoading());
    try {
      final challengesResp = await GetChallengesUseCase(repository: getIt())
          .call(GetChallengesParams(
              challengeType: "ALL",
              period: "CURRENT",
              uid: getIt<GlobalConfiguration>().profile.uID ?? ""));
      challengesResp
          .fold((l) => emit(OnGoingChallengeError(message: l.message)), (r) {
        final List<GetChallenges> globalChallenges =
            r.where((element) => element.challengeType == "GLOBAL").toList();
        final List<GetChallenges> corporateChallenges =
            r.where((element) => element.challengeType == "CORPORATE").toList();
        final List<GetChallenges> groupChallenges =
            r.where((element) => element.challengeType == "GROUP").toList();
        emit(OnGoingChallengeLoaded(
            challenges: r,
            groupChallenges: groupChallenges,
            corporateChallenges: corporateChallenges,
            globalChallenges: globalChallenges));
      });
    } catch (e) {
      emit(OnGoingChallengeError(message: e.toString()));
    }
  }
}
