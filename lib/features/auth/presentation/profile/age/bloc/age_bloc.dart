import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/auth/domain/usecases/add_user_profie_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'age_event.dart';
part 'age_state.dart';

class AgeBloc extends Bloc<AgeEvent, AgeState> {
  AgeBloc() : super(AgeInitial()) {
    on<SaveAgeBtnClicked>((event, emit) async {
      final profile =
          await getIt<AppDatabase>().userProfileDao.getUserProfile();
      if (profile != null) {
        profile.uID = getIt<SharedPreferences>().getString("uid");
        profile.dateOfBirth = DateUtility.formatDateTime(dateTime: event.dob);
        await getIt<AppDatabase>().userProfileDao.updateUserProfile(profile);
        getIt<GlobalConfiguration>().profile = profile;
        final response =
            await AddUserProfileUseCase(repository: getIt()).call(profile);
        response.fold((l) => emit(AgeError(l.message)), (r) {
          if (r.errorMessage == "") {
            emit(AgeSaved());
          } else {
            emit(AgeError(r.errorMessage ?? "Server error"));
          }
        });
      } else {
        emit(AgeError("User profile not found"));
      }
    });
  }
}
