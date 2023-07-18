import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/group_challenges/domain/usecases/get_all_badges_usecase.dart';
import 'package:tres_connect/features/group_challenges/presentation/all_badges/all_badges/bloc/all_badges_event.dart';
import 'package:tres_connect/features/group_challenges/presentation/all_badges/all_badges/bloc/all_badges_state.dart';

class AllBadgesBloc extends Bloc<AllBadgesEvent, AllBadgesState> {
  AllBadgesBloc() : super(AllBadgesLoading()) {
    on<AllBadgesLoadEvent>(_loadAllBadgesList);
    on<GetAllBadgesClicked>(_clickedAllBadgesList);
  }

  void _loadAllBadgesList(
      AllBadgesLoadEvent event, Emitter<AllBadgesState> emit) async {
    emit(AllBadgesLoading());
  }

  _clickedAllBadgesList(
      GetAllBadgesClicked event, Emitter<AllBadgesState> emit) async {
    emit(AllBadgesLoading());
    try {
      final participantRes = await GetAllBadgesUseCase(repository: getIt())
          .call(GetAllBadgesParams(
              uid: event.uid,
              pageSize: event.pageSize,
              challengeid: event.challengeid,
              startIndex: event.startIndex));
      participantRes.fold((l) => emit(AllBadgesError(message: l.message)),
          (r) => emit(AllBadgesLoaded(getAllBadgeByUserId: r)));
    } catch (e) {
      emit(AllBadgesError(message: e.toString()));
    }
  }
}
