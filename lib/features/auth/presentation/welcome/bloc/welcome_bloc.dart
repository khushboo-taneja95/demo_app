import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/usecase/usecase.dart';
import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:tres_connect/features/auth/domain/usecases/login_via_apple_usecase.dart';
import 'package:tres_connect/features/auth/domain/usecases/login_via_fb_usecase.dart';
import 'package:tres_connect/features/auth/domain/usecases/login_via_google_usecase.dart';
import 'package:tres_connect/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:tres_connect/global_configuration.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<LoginWithGoogleBtnClicked>(_loginWithGoogleBtnClicked);
    on<LoginWithFacebookBtnClicked>(_loginWithFacebookBtnClicked);
    on<LoginWithAppleBtnClicked>(_loginWithAppleBtnClicked);
  }

  void _loginWithGoogleBtnClicked(
      LoginWithGoogleBtnClicked event, Emitter<WelcomeState> emit) async {
    emit(WelcomeLoading());
    //api call via usecase
    final result = await LoginViaGoogle(repository: getIt()).call(NoParams());
    result.fold((l) {
      emit(WelcomeFailure(message: l.message));
    }, (r) async {
      await loginLogic(r);
    });
  }

  void _loginWithFacebookBtnClicked(
      LoginWithFacebookBtnClicked event, Emitter<WelcomeState> emit) async {
    emit(WelcomeLoading());
    //api call via usecase
    final result = await LoginViaFacebook(repository: getIt()).call(NoParams());
    result.fold((l) {
      emit(WelcomeFailure(message: l.message));
    }, (r) async {
      await loginLogic(r);
    });
  }

  void _loginWithAppleBtnClicked(
      LoginWithAppleBtnClicked event, Emitter<WelcomeState> emit) async {
    emit(WelcomeLoading());
    //api call via usecase
    final result = await LoginViaApple(repository: getIt()).call(NoParams());
    result.fold((l) {
      emit(WelcomeFailure(message: l.message));
    }, (r) async{
      await loginLogic(r);
    });
  }

  Future<void> loginLogic(AuthResponseEntity r) async {
String routeName = Routes.login;
      if (r.accessToken != null && r.userDetail != null) {
        //insert user profile info in database
        final userDetails = jsonDecode(r.userDetail!);
        UserProfileEntiry profileInfo = UserProfileEntiry();
        profileInfo.uID = userDetails['UID'];
        profileInfo.firstName = userDetails['FullName'];
        profileInfo.emailId = userDetails['EmailId'];
        profileInfo.mobileNo = userDetails['MobileNo'];
        profileInfo.authorizationToken = r.accessToken;
        profileInfo.loginSource = Platform.isAndroid ? 'Android' : 'iOS';
        await getIt<AppDatabase>().userProfileDao.deleteUserProfile();
        // await getIt<AppDatabase>()
        //     .userProfileDao
        //     .insertUserProfile(profileInfo);
        await GetUserProfileUseCase(repository: getIt())
            .call(r.uID!)
            .then((value) {
          value.fold((l) => null, (r) async {
            profileInfo.gender = r.gender;
            profileInfo.dateOfBirth = r.dateOfBirth;
            profileInfo.height = r.height;
            profileInfo.weight = r.weight;
            profileInfo.dateCreated = r.dateCreated;
            profileInfo.profileImage = r.cropUserProfilePicture;
            await getIt<AppDatabase>()
                .userProfileDao
                .insertUserProfile(profileInfo);

            //Fetch health rating
            HealthRatingEntity ratingEntity = HealthRatingEntity();
            String riskRating = "";
            if (r.lastHealthRiskRating == "Normal") {
              riskRating = "Green";
            } else if (r.lastHealthRiskRating == "Cautious") {
              riskRating = "Orange";
            } else if (r.lastHealthRiskRating == "Risk") {
              riskRating = "Red";
            }
            ratingEntity.hIsSynced = "1";
            ratingEntity.userID = r.uID;
            ratingEntity.healthRatingTimeStamp = r.lastHealthStatusTime;
            ratingEntity.riskRating = riskRating;
            ratingEntity.remarkStatusTime = r.remarksStatusTime;
            ratingEntity.reasonToShow = r.reasonToShow;
            ratingEntity.riskValue = r.lastHealthRiskValue;
            ratingEntity.travelStatus = r.travelStatus;
            ratingEntity.travelReason = r.travelReason;
            ratingEntity.remarks = r.remarks;
            ratingEntity.healthRatingUserLatitude = "";
            ratingEntity.healthRatingUserLongitude = "";
            getIt<AppDatabase>()
                .healthRatingDao
                .insertHealthRating(ratingEntity);
          });
        });
        final userProfile =
            await getIt<AppDatabase>().userProfileDao.getUserProfile();
        if (userProfile == null) {
          routeName = Routes.login;
          emit(const WelcomeFailure(message: "Error saving user profile"));
          return;
        }
        userProfile.gender = profileInfo.gender;
        userProfile.dateOfBirth = profileInfo.dateOfBirth;
        userProfile.height = profileInfo.height;
        userProfile.weight = profileInfo.weight;
        profileInfo.dateCreated = profileInfo.dateCreated;
        userProfile.profileImage = profileInfo.cropUserProfilePicture;

        getIt<GlobalConfiguration>().profile = userProfile;

        //save access token in shared preferences
        await getIt<SharedPreferences>()
            .setString('access_token', r.accessToken!);
        await getIt<SharedPreferences>().setString('expires_in', r.expires!);
        await getIt<SharedPreferences>().setString('uid', r.uID!);
        await getIt<SharedPreferences>()
            .setString('refresh_token', r.refreshToken!);
        await getIt<SharedPreferences>().setBool("is_first", false);
        //logic to redirect user to next screen
        if (userProfile.gender == null ||
            userProfile.gender!.isEmpty ||
            userProfile.height == null ||
            userProfile.weight == null) {
          routeName = Routes.profileGender;
        } else {
          routeName = Routes.dashboard;
        }
        emit(WelcomeSuccess(routeName: routeName));
      } else {
        emit(WelcomeFailure(message: "Access token not found"));
      }
  }
}
