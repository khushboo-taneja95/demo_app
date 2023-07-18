import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:tres_connect/global_configuration.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInit>(_splashInit);
  }

  void _splashInit(SplashInit event, Emitter<SplashState> emit) async {
    var prefs = getIt<SharedPreferences>();
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 3));
    //Check app update
    //Check user login

    final userProfile =
        await getIt<AppDatabase>().userProfileDao.getUserProfile();

    String routeName = Routes.welcomePage;
    String? accessToken = prefs.getString("access_token");
    String? expiresIn = prefs.getString("expires_in");
    String? uid = prefs.getString("uid");
    if (accessToken != null &&
        expiresIn != null &&
        uid != null &&
        userProfile != null) {
      //Check token expiry
      // if(DateTime.parse(expiresIn).isBefore(DateTime.now()))) {
      //   //Redirect to login page
      // }

      final response = await GetUserProfileUseCase(repository: getIt())
          .call(userProfile.uID!);
      response.fold((l) => null, (r) {
        userProfile.dateOfBirth = r.dateOfBirth;
        userProfile.cropUserProfilePicture = r.cropUserProfilePicture;
        userProfile.emergencyContacts = r.emergencyContacts;
        userProfile.gender = r.gender;
        userProfile.height = r.height;
        getIt<AppDatabase>()
            .userProfileDao
            .updateUserProfile(userProfile)
            .then((value) => null);
      });

      getIt<GlobalConfiguration>().profile = userProfile;
      //getIt<GlobalConfiguration>().uID = uid;
      getIt<GlobalConfiguration>().emailId = userProfile.emailId ?? "";

      // getIt<GlobalConfiguration>().profile.imageUrl = profileImage.path;
      routeName = Routes.dashboard;
      //routeName = Routes.testScreen;
      //Check mobile verified

      if (userProfile.mobileNo == null ||
          userProfile.mobileNo == "" ||
          userProfile.mobileNo == "0") {
        routeName = Routes.mobileVerification;
      }
      if (userProfile.gender == null ||
          userProfile.gender!.isEmpty ||
          userProfile.height == null ||
          userProfile.weight == null) {
        routeName = Routes.profileGender;
      }
    } else {
      routeName = Routes.welcomePage;
    }
    emit(SplashLoaded(routeName: routeName));
  }
}
