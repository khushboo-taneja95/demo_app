import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/features/group_challenges/data/models/create_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/data/models/delete_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_my_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/data/models/update_challenges_models.dart';

abstract class CreateChallengesRemoteDataSource {
  Future<CreateChallengesModel> createChallenges({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    required File? challengeImage,
    required String creationDate,
    required String group_name,
    required String group_uid,
    required String badge_one,
    required String badge_two,
    required String? badge_three,
    required String badge_completion,
  });

  Future<GetAllBadgeModel> getAllBadge({required String Rank});

  Future<GetMyChallengesModels> getMyChallenge(
      {required String uid,
      required String startIndex,
      required String pageSize});

  Future<UpdateChallengeModels> challengeUpdate({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    // required File? challengeImage,
    required String creationDate,
    required String challengeId,
  });

  Future<DeleteChallengeModels> deleteChallenges({required String challengeId});
}

class CreateChallengesRemoteDataSourceImpl
    extends CreateChallengesRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<CreateChallengesModel> createChallenges({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    required File? challengeImage,
    required String creationDate,
    required String group_name,
    required String group_uid,
    required String badge_one,
    required String badge_two,
    required String? badge_three,
    required String badge_completion,
  }) async {
    final data = FormData.fromMap({
      "challengeType": challengeType,
      "createdBy": createdBy,
      "challengeTitle": challengeTitle,
      "challengeTarget": challengeTarget,
      "challengeStartDate": challengeStartDate,
      "challengeEndDate": challengeEndDate,
      "challengeDetails": challengeDetails,
      "challengeImage": await MultipartFile.fromFile(challengeImage!.path,
          filename: "file.jpg"),
      "creationDate": creationDate,
      "group_name": group_name,
      "group_uid": group_uid,
      "badge_one": badge_one,
      "badge_two": badge_two,
      "badge_three": badge_three,
      "badge_completion": badge_completion,
    });

    final response = await dio.post(AppUrl.createChallenges,
        data: data,
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: Headers.multipartFormDataContentType));
    final model = CreateChallengesModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }

  @override
  Future<GetAllBadgeModel> getAllBadge({
    required String Rank,
  }) async {
    final response = await dio.post(AppUrl.getAllBadge, data: {
      "Rank": Rank,
    });
    var baseResponseModel = GetAllBadgeModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return baseResponseModel;
    } else {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<GetMyChallengesModels> getMyChallenge({
    required String uid,
    required String startIndex,
    required String pageSize,
  }) async {
    final response = await dio.post(
      AppUrl.getMyChallenge,
      data: {
        "uid": uid,
        "startIndex": startIndex,
        "pageSize": pageSize,
      },
    );
    final model = GetMyChallengesModels.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else if (model.status == 2) {
      throw Exception("Code ${response.statusCode}");
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }

  @override
  Future<UpdateChallengeModels> challengeUpdate({
    required String challengeType,
    required String createdBy,
    required String challengeTitle,
    required String challengeTarget,
    required String challengeStartDate,
    required String challengeEndDate,
    required String challengeDetails,
    // required File? challengeImage,
    required String creationDate,
    required String challengeId,
  }) async {
    final response = await dio.post(
      AppUrl.challengeUpdate,
      data: {
        "challengeType": challengeType,
        "createdBy": createdBy,
        "challengeTitle": challengeTitle,
        "challengeTarget": challengeTarget,
        "challengeStartDate": challengeStartDate,
        "challengeEndDate": challengeEndDate,
        "challengeDetails": challengeDetails,
        // "challengeImage": challengeImage,
        "creationDate": creationDate,
        "challengeId": challengeId,
      },
    );
    final model = UpdateChallengeModels.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }

  @override
  Future<DeleteChallengeModels> deleteChallenges({
    required String challengeId,
  }) async {
    final response = await dio.post(
      AppUrl.deleteChallenges,
      data: {
        "challengeId": challengeId,
      },
    );
    final model = DeleteChallengeModels.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
