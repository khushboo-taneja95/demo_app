class WatchConstants {
  static const TRES_WATCH = ["CARE C303"];
  static const ECG_PATCH = ["J1791"];
  static const GLOW_LUXE_WATCH = ["Glow Luxe"];
  static const SLATE_WATCH = ["Slate", "HT5"];
  static const ULTRA_WATCH = ["Ultra"];
  static const BLAZE_WATCH = ["Blaze"];
  static const BLAZE_MAX_WATCH = ["ZW01"];
  static const STAR_WATCH = ["GizFit STAR"];

  static const TRES_WATCHES = [...TRES_WATCH, ...ECG_PATCH];
  static const GIZMORE_WATCHES = [
    ...GLOW_LUXE_WATCH,
    ...SLATE_WATCH,
    ...ULTRA_WATCH,
    ...BLAZE_WATCH,
    ...BLAZE_MAX_WATCH,
    ...STAR_WATCH
  ];

  static const ALL_SUPPORTED_WATCHES = [...TRES_WATCHES, ...GIZMORE_WATCHES];

  static bool isWatchSupported(String deviceName) {
    for (var watch in ALL_SUPPORTED_WATCHES) {
      if (deviceName.toUpperCase().contains(watch.toUpperCase())) return true;
    }
    return false;
  }

  static bool compareDeviceName(String deviceName, List<String> watchName) {
    for (var watch in watchName) {
      if (deviceName.toUpperCase().contains(watch.toUpperCase())) return true;
    }
    return false;
  }

  static bool isTresWatch(String deviceName) {
    return TRES_WATCHES.contains(deviceName);
  }

  static bool isGizmoreWatch(String deviceName) {
    return GIZMORE_WATCHES.contains(deviceName);
  }
}
