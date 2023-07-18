import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/usecases/update_profie_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  WeightBloc() : super(WeightInitial()) {
    on<SaveWeightBtnClicked>((event, emit) async {
      emit(WeightInitial());
      final profile =
          await getIt<AppDatabase>().userProfileDao.getUserProfile();
      if (profile != null) {
        profile.uID = getIt<SharedPreferences>().getString("uid");
        profile.weight = event.weight;
        await getIt<AppDatabase>().userProfileDao.updateUserProfile(profile);
        if (event.isEditing) {
          await UpdateProfileUseCase(repository: getIt()).call(profile);
        }
        getIt<GlobalConfiguration>().profile = profile;
      }
      emit(WeightSaved());
    });
  }
}
