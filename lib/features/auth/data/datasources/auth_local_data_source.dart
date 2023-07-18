import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';

abstract class AuthLocalDataSource {
  String? getToken();
  DateTime getExpiryTime();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  DateTime getExpiryTime() {
    String? tokenExpiryTime = getIt<SharedPreferences>().getString("expires");
    if (tokenExpiryTime != null) {
      return DateUtility.parseDateTime(dateTimeString: tokenExpiryTime);
    } else {
      return DateTime.now().add(const Duration(days: -1));
    }
  }

  @override
  String? getToken() {
    return getIt<SharedPreferences>().getString("access_token");
  }

  Future<UserProfileEntiry?> getUserProfile() async {
    return await getIt<AppDatabase>().userProfileDao.getUserProfile();
  }

  Future<void> saveUserProfile(UserProfileEntiry userProfile) async {
    final profile = await getUserProfile();
    if (profile != null) {
      await getIt<AppDatabase>().userProfileDao.insertUserProfile(userProfile);
    }
  }
}
