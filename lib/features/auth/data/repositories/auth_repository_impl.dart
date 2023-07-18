import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tres_connect/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tres_connect/features/auth/data/models/qr_code_response.dart';
import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  late AuthLocalDataSource authLocalDataSource;
  late AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl() {
    authLocalDataSource = AuthLocalDataSourceImpl();
    authRemoteDataSource = AuthRemoteDataSourceImpl();
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> loginViaEmail(
      String email, String password) async {
    try {
      final authResponse = await authRemoteDataSource.loginViaEmail(
          email: email,
          password: password,
          name: "",
          source: "",
          token: "",
          clientId: "client1",
          clientSecret: "secret",
          grantType: "password");
      return Right(authResponse);
    } on DioException catch (e) {
      var response = e.response;
      return Left(ServerFailure(
          response?.data['error_description'].toString() ?? e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> registerViaEmail(
      String name, String email, String password) async {
    try {
      final registerResponse = await authRemoteDataSource.register(
          name: name, email: email, password: password, source: "");
      if (registerResponse.errorMessage?.isEmpty == true) {
        return Right(registerResponse);
      } else {
        return Left(
            ServerFailure(registerResponse.errorMessage ?? "Unknown Error"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> forgotPassword(
      String email) async {
    try {
      final registerResponse =
          await authRemoteDataSource.forgotPassword(email: email);
      if (registerResponse.errorMessage?.isEmpty == true) {
        return Right(registerResponse);
      } else {
        return Left(
            ServerFailure(registerResponse.errorMessage ?? "Unknown Error"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> mobileNumberVerification(
      String mobileno) async {
    try {
      final mobilevalidationResponse = await authRemoteDataSource
          .mobileNumberVerification(mobileno: mobileno);
      if (mobilevalidationResponse.errorMessage?.isEmpty == true) {
        return Right(mobilevalidationResponse);
      } else {
        return Left(ServerFailure(
            mobilevalidationResponse.errorMessage ?? "Unknown Error"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> updateUserName(
      String uid, String username, String mobileno) async {
    try {
      final UpdateUserNameResponse = await authRemoteDataSource.updateUserName(
          uid: uid, username: username, mobileno: mobileno);
      if (UpdateUserNameResponse.errorMessage?.isEmpty == true) {
        return Right(UpdateUserNameResponse);
      } else {
        return Left(ServerFailure(
            UpdateUserNameResponse.errorMessage ?? "Unknown Error"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> refreshToken() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredentials.user != null) {
        final user = await authRemoteDataSource.loginViaEmail(
            email: userCredentials.user!.email!,
            password: "",
            name: userCredentials.user!.displayName!,
            source: "Google",
            token: "",
            clientId: "client1",
            clientSecret: "secret",
            grantType: "password");
        return Right(user);
      } else {
        return const Left(ServerFailure("User details not available"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> loginWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken == null) {
        return const Left(ServerFailure("User cancelled the login"));
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final userCredentials = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      // userCredentials.additionalUserInfo.profile[0]
      Map<String, dynamic> dict = {};
      dict = userCredentials.additionalUserInfo!.profile!;
      String email = dict["email"];
      String name = dict["name"];

      if (userCredentials.user != null) {
        final user = await authRemoteDataSource.loginViaEmail(
            email: email,
            password: "",
            name: name,
            source: "fb",
            token: "",
            clientId: "client1",
            clientSecret: "secret",
            grantType: "password");
        return Right(user);
      } else {
        return const Left(ServerFailure("User details not available"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> loginWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      var userCredentials =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      if (userCredentials.user != null) {
        final user = await authRemoteDataSource.loginViaEmail(
            email: userCredentials.user!.email!,
            password: "",
            name: userCredentials.user!.displayName!,
            source: "Apple",
            token: "",
            clientId: "client1",
            clientSecret: "secret",
            grantType: "password");
        return Right(user);
      } else {
        return const Left(ServerFailure("User details not available"));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntiry>> getProfile(String uid) async {
    try {
      final data = await authRemoteDataSource.getUserProfile(uid);
      if (data.userProfileInfo != null) {
        final userProfile =
            await getIt<AppDatabase>().userProfileDao.getUserProfile();
        if (userProfile != null) {
          userProfile.dateOfBirth = data.userProfileInfo!.dateOfBirth;
          userProfile.height = data.userProfileInfo!.height;
          userProfile.uID = getIt<SharedPreferences>().getString("uid");
          userProfile.weight = data.userProfileInfo!.weight;
          userProfile.gender = data.userProfileInfo!.gender;
          await getIt<AppDatabase>()
              .userProfileDao
              .insertUserProfile(userProfile);
        }
        return Right(data.userProfileInfo!);
      } else {
        return Left(ServerFailure(data.errorMessage ?? "Unknown Error"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> updateProfile(
      UserProfileEntiry profile) async {
    try {
      final mapData = {
        'DateOfBirth': '${profile.dateOfBirth}',
        'Height': '${profile.height}',
        'UID': '${profile.uID}',
        'Weight': '${profile.weight}',
        'Gender': '${profile.gender}',
        'DeviceOS': '${profile.loginSource}',
        'DeviceID': getIt<SharedPreferences>().getString("device_token") ?? '',
        'MedicalAssistance': '',
        'Location': '',
        'Datasharing': ''
      };
      final data = await authRemoteDataSource.updateUserProfile(mapData);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> addUserProfile(
      UserProfileEntiry profile) async {
    try {
      final mapData = {
        'DateOfBirth': '${profile.dateOfBirth}',
        'Height': '${profile.height}',
        'UID': '${profile.uID}',
        'Weight': '${profile.weight}',
        'Gender': '${profile.gender}',
        'DeviceOS': '${profile.loginSource}',
        'DeviceID': '',
        'MedicalAssistance': '',
        'Location': '',
        'Datasharing': ''
      };
      final data = await authRemoteDataSource.addUserProfile(mapData);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> verifyPhoneNo({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<Either<Failure, QRCodeResponse>> getQRCode(
      {required String name, required String uid}) async {
    try {
      final data = await authRemoteDataSource.getQRCode(name: name, uid: uid);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
