import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_challenges_usecase.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_check_result_usecase.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/presentation/check_result/bloc/check_result_event.dart';
import 'package:tres_connect/features/group_challenges/presentation/check_result/bloc/check_result_state.dart';
import 'package:tres_connect/global_configuration.dart';

class CheckResultBloc extends Bloc<CheckResultEvent, CheckResultState> {
  CheckResultBloc() : super(CheckResultLoading()) {
    on<LoadPastChallengesEvent>(_loadPastChallenges);
    on<CheckResultLoadEvent>(_loadCheckResult);
    on<GetCheckResultClicked>(_clickedCheckResult);
  }

  void _loadPastChallenges(
      LoadPastChallengesEvent event, Emitter<CheckResultState> emit) async {
    emit(CheckResultLoading());
    try {
      final challengesResp = await GetChallengesUseCase(repository: getIt())
          .call(GetChallengesParams(
              challengeType: "ALL",
              period: "PAST",
              uid: getIt<GlobalConfiguration>().profile.uID ?? ""));
      challengesResp.fold((l) => emit(CheckResultError(message: l.message)),
          (r) {
        final List<GetChallenges> globalChallenges =
            r.where((element) => element.challengeType == "GLOBAL").toList();
        final List<GetChallenges> corporateChallenges =
            r.where((element) => element.challengeType == "CORPORATE").toList();
        final List<GetChallenges> groupChallenges =
            r.where((element) => element.challengeType == "GROUP").toList();
        emit(OnPastChallengeLoaded(
            challenges: r,
            groupChallenges: groupChallenges,
            corporateChallenges: corporateChallenges,
            globalChallenges: globalChallenges));
      });
    } catch (e) {
      emit(CheckResultError(message: e.toString()));
    }
  }

  void _loadCheckResult(
      CheckResultEvent event, Emitter<CheckResultState> emit) async {
    emit(CheckResultLoading());
  }

  _clickedCheckResult(
      GetCheckResultClicked event, Emitter<CheckResultState> emit) async {
    emit(CheckResultLoading());
    try {
      final participantRes = await GetCheckResultUseCase(repository: getIt())
          .call(GetCheckResultParams(
              uid: event.uid, challengeid: event.challengeid));
      participantRes.fold((l) => emit(CheckResultError(message: l.message)),
          (r) => emit(CheckResultLoaded(checkResult: r)));
    } catch (e) {
      emit(CheckResultError(message: e.toString()));
    }
  }
}
