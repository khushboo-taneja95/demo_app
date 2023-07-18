import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/join_challenges_usescases.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/leave_challenges_usescases.dart';
part 'challenges_details_events.dart';
part 'challenges_details_state.dart';

class ChallengeDetailsBloc
    extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  ChallengeDetailsBloc() : super(ChallengeDetailsInitial()) {
    on<ChallengeDetailsLoadedEvent>(_loadChallengeDetails);
    on<ChallengeDetailsClicked>(_joinChallenges);
    on<LeaveChallengeClicked>(_leaveChallenges);
  }

  _loadChallengeDetails(
      ChallengeDetailsLoadedEvent event, Emitter<ChallengeDetailsState> emit) {
    emit(ChallengeDetailsInitial());

    emit(ChallengeDetailsLoaded(
      uid: event.uid,
      isJoined: event.isJoined,
      challengeId: event.challengeId,
    ));
  }

  _joinChallenges(ChallengeDetailsClicked event,
      Emitter<ChallengeDetailsState> emit) async {
    emit(ChallengeDetailsLoading());
    if (event != null) {
      final challengeDetailsResp =
          await JoinChallengesUseCase(repository: getIt())
              .call(JoinChallengesParams(
        uid: event.uid,
        challengeId: event.challengeId,
      ));
      challengeDetailsResp.fold((l) {
        emit(ChallengeDetailsError(message: l.message));
      }, (r) {
        emit(ChallengeDetailsLoaded(
          uid: event.uid,
          isJoined: true,
          challengeId: event.challengeId,
        ));
      });
    } else {
      emit(ChallengeDetailsLoaded(
        uid: event.uid,
        isJoined: false,
        challengeId: event.challengeId,
      ));
    }
  }

  _leaveChallenges(
      LeaveChallengeClicked event, Emitter<ChallengeDetailsState> emit) async {
    emit(ChallengeDetailsLoading());
    if (event != null) {
      final leavechallengesResp =
          await LeaveChallengesUseCase(repository: getIt())
              .call(LeaveChallengesParams(
        participantUid: event.participantUid,
        challengeId: event.challengeId,
      ));
      leavechallengesResp.fold((l) {
        emit(ChallengeDetailsError(message: l.message));
      }, (r) {
        emit(ChallengeDetailsLoaded(
          uid: event.participantUid,
          isJoined: false,
          challengeId: event.challengeId,
        ));
      });
    } else {
      emit(ChallengeDetailsLoaded(
        uid: event.participantUid,
        challengeId: event.challengeId,
      ));
    }
  }
}
