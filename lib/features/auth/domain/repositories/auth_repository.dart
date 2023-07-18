import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tres_connect/core/errors/failures.dart';
import 'package:tres_connect/features/auth/data/models/qr_code_response.dart';
import 'package:tres_connect/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/base_reponse_entity.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> loginViaEmail(
      String email, String password);
  Future<Either<Failure, BaseResponseEntity>> registerViaEmail(
      String name, String email, String password);
  Future<Either<Failure, BaseResponseEntity>> forgotPassword(String Emailid);
  Future<Either<Failure, BaseResponseEntity>> mobileNumberVerification(
      String mobileno);
  Future<Either<Failure, BaseResponseEntity>> updateUserName(
      String uid, String username, String mobileno);
  Future<Either<Failure, BaseResponseEntity>> refreshToken();
  Future<Either<Failure, AuthResponseEntity>> loginWithGoogle();
  Future<Either<Failure, AuthResponseEntity>> loginWithFacebook();
  Future<Either<Failure, AuthResponseEntity>> loginWithApple();
  Future<void> verifyPhoneNo({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  //Profile
  Future<Either<Failure, UserProfileEntiry>> getProfile(String uid);
  Future<Either<Failure, BaseResponseEntity>> addUserProfile(
      UserProfileEntiry profile);
  Future<Either<Failure, BaseResponseEntity>> updateProfile(
      UserProfileEntiry profile);
  Future<Either<Failure, QRCodeResponse>> getQRCode(
      {required String name, required String uid});
}
