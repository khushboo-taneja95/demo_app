import 'package:dio/dio.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/networking/urls.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_participant_model.dart';
import 'package:tres_connect/global_configuration.dart';

abstract class ParticipantsRemoteDataSource {
  Future<GetParticipantModel> getParticipants({
    required String Search,
    required String Id,
    required String pageSize,
  });
}

class ParticipantsRemoteDataSourceImpl extends ParticipantsRemoteDataSource {
  final dio = getIt<Dio>();

  @override
  Future<GetParticipantModel> getParticipants(
      {required String Search,
      required String Id,
      required String pageSize}) async {
    final response = await dio.post(AppUrl.GET_PARTICIPANT,
        data: {
          "Search": Search,
          "Id": Id,
          "pageSize": pageSize,
          "user_uid": getIt<GlobalConfiguration>().profile.uID ?? "".trim()
        },
        options: Options(
            headers: {"Authorization": 'Basic Y2xpZW50MTpzZWNyZXQ='},
            contentType: "application/json"));
    final model = GetParticipantModel.fromJson(response.data);
    if (response.statusCode == 200 && model.status == 1) {
      return model;
    } else {
      throw Exception("Code ${response.statusCode}");
    }
  }
}
