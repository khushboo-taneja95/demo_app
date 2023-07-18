import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/usecases/update_profie_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'height_event.dart';
part 'height_state.dart';

class HeightBloc extends Bloc<HeightEvent, HeightState> {
  HeightBloc() : super(HeightInitial()) {
    on<SaveHeightBtnClicked>((event, emit) async {
      emit(HeightInitial());
      final profile =
          await getIt<AppDatabase>().userProfileDao.getUserProfile();
      if (profile != null) {
        profile.uID = getIt<SharedPreferences>().getString("uid");
        profile.height = event.height;
        await getIt<AppDatabase>().userProfileDao.updateUserProfile(profile);
        if (event.isEditing) {
          await UpdateProfileUseCase(repository: getIt()).call(profile);
        }
        getIt<GlobalConfiguration>().profile = profile;
      }
      emit(HeightSaved());
    });
  }
}
