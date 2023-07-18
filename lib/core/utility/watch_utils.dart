import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/constants/watch_constants.dart';
import 'package:tres_connect/core/di/injection.dart';

class WatchUtils {
  static String? getBrandLogo() {
    String? deviceName = getIt<SharedPreferences>().getString("deviceName");
    if (deviceName == null) {
      return null;
    } else if (containsInArray(deviceName, WatchConstants.TRES_WATCHES)) {
      return "assets/images/tres_logo.png";
    } else if (containsInArray(deviceName, WatchConstants.GIZMORE_WATCHES)) {
      return "assets/images/logo_gizmore.png";
    }
    return null;
  }

  static bool containsInArray(String value, List<String> array) {
    for (String item in array) {
      if (item.contains(value)) {
        return true;
      }
    }
    return false;
  }


}
