import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_participants_usecase.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/like_unlike_usecase.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_participant_model.dart';

part 'participants_event.dart';
part 'participants_state.dart';

class ParticipantsBloc extends Bloc<ParticipantEvent, ParticipantState> {
  ParticipantsBloc() : super(ParticipantLoading()) {
    on<ParticipantLoadEvent>(_loadParticipant);
    on<ParticipantClicked>(_clickedParticipant);
    on<LikeUnlikeClicked>(_clickedLikeUnlikeParticipant);
  }

  void _loadParticipant(
      ParticipantLoadEvent event, Emitter<ParticipantState> emit) async {
    emit(ParticipantLoading());
  }

  _clickedLikeUnlikeParticipant(
      LikeUnlikeClicked event, Emitter<ParticipantState> emit) async {
    //emit(const CreateChallengeLoading());
    if (event != null) {
      final challengeResp = await LikeUnlikeUseCase(repository: getIt())
          .call(CreateLikeUnlikeParams(
        challengeid: event.challengeid,
        participant_uid: event.participant_uid,
        reacted_by: event.reacted_by,
        reaction: event.reaction,
      ));
      challengeResp.fold((l) {
        emit(ParticipantError(message: l.message));
      }, (r) {
        add(ParticipantClicked(
            pagesize: '500',
            id: event.challengeid,
            search: '',
            challengeId: event.challengeid,
            uid: event.participant_uid));
        // emit(LikeUnlikeLoaded(
        //   challengeid: event.challengeid,
        //   participant_uid: event.participant_uid,
        //   reacted_by: event.reacted_by,
        //   reaction: event.reaction,
        // ));
      });
    } else {
      // emit(LikeUnlikeLoaded(
      //   challengeid: event.challengeid,
      //   participant_uid: event.participant_uid,
      //   reacted_by: event.reacted_by,
      //   reaction: event.reaction,
      // ));
    }
  }

  _clickedParticipant(
      ParticipantClicked event, Emitter<ParticipantState> emit) async {
    emit(ParticipantLoading());
    try {
      final participantRes = await GetParticipantsUseCase(repository: getIt())
          .call(GetParticipantsParams(
        id: int.parse(event.id),
        pagesize: int.parse(event.pagesize),
        search: event.search,
      ));
      participantRes.fold((l) => emit(ParticipantError(message: l.message)),
          (r) => emit(ParticipantLoaded(getParticipants: r)));
    } catch (e) {
      emit(ParticipantError(message: e.toString()));
    }
  }
}
