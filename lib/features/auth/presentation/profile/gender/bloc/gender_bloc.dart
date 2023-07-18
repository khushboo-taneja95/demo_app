import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/usecases/update_profie_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  GenderBloc() : super(GenderInitial()) {
    on<SaveGenderBtnClicked>((event, emit) async {
      emit(GenderInitial());
      final profile =
          await getIt<AppDatabase>().userProfileDao.getUserProfile();
      if (profile != null) {
        profile.uID = getIt<SharedPreferences>().getString("uid");
        profile.gender = event.gender;
        if (event.isEditing) {
          await UpdateProfileUseCase(repository: getIt()).call(profile);
        }
        await getIt<AppDatabase>().userProfileDao.updateUserProfile(profile);
        getIt<GlobalConfiguration>().profile = profile;
      }
      emit(GenderSaved(event.gender));
    });
  }
}
