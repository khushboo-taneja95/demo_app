import 'package:equatable/equatable.dart';
import 'package:tres_connect/features/group_challenges/data/models/liked_list_model.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/liked_list_usecase.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';

part 'liked_list_event.dart';
part 'liked_list_state.dart';

class LikedListBloc extends Bloc<LikeListEvent, LikeListState> {
  LikedListBloc() : super(LikedListLoading()) {
    on<LikeListLoadEvent>(_loadLikedList);
    on<LikeListClicked>(_clickedLikedList);
  }

  void _loadLikedList(
      LikeListLoadEvent event, Emitter<LikeListState> emit) async {
    emit(LikedListLoading());
  }

  _clickedLikedList(LikeListClicked event, Emitter<LikeListState> emit) async {
    emit(LikedListLoading());
    try {
      final participantRes = await LikedListUseCase(repository: getIt()).call(
          GetLikedListParams(
              uid: event.uid,
              pageSize: event.pageSize,
              challengeid: event.challengeid,
              startIndex: event.startIndex));
      participantRes.fold((l) => emit(LikeListError(message: l.message)),
          (r) => emit(LikedListLoaded(listOfLikesChallenge: r)));
    } catch (e) {
      emit(LikeListError(message: e.toString()));
    }
  }
}
