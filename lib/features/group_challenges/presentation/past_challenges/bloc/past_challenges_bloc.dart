import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_challenges_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'past_challenges_event.dart';
part 'past_challenges_state.dart';

class PastChallengesBloc
    extends Bloc<PastChallengesEvent, PastChallengesState> {
  PastChallengesBloc() : super(PastChallengesInitial()) {
    on<LoadPastChallengesEvent>(_loadPastChallenges);
  }

  void _loadPastChallenges(
      LoadPastChallengesEvent event, Emitter<PastChallengesState> emit) async {
    emit(PastChallengesLoading());
    try {
      final challengesResp = await GetChallengesUseCase(repository: getIt())
          .call(GetChallengesParams(
              challengeType: "ALL",
              period: "PAST",
              uid: getIt<GlobalConfiguration>().profile.uID ?? ""));
      challengesResp.fold((l) => emit(PastChallengesError(message: l.message)),
          (r) {
        final List<GetChallenges> globalChallenges =
            r.where((element) => element.challengeType == "GLOBAL").toList();
        final List<GetChallenges> corporateChallenges =
            r.where((element) => element.challengeType == "CORPORATE").toList();
        final List<GetChallenges> groupChallenges =
            r.where((element) => element.challengeType == "GROUP").toList();
        emit(PastChallengesLoaded(
            challenges: r,
            groupChallenges: groupChallenges,
            corporateChallenges: corporateChallenges,
            globalChallenges: globalChallenges));
      });
    } catch (e) {
      emit(PastChallengesError(message: e.toString()));
    }
  }
}
