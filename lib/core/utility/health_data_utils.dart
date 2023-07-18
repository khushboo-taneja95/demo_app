import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';

/// List of data types available on iOS
const List<HealthDataType> dataTypesIOS = [
  HealthDataType.ACTIVE_ENERGY_BURNED,
  HealthDataType.AUDIOGRAM,
  HealthDataType.BASAL_ENERGY_BURNED,
  HealthDataType.BLOOD_GLUCOSE,
  HealthDataType.BLOOD_OXYGEN,
  HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
  HealthDataType.BODY_FAT_PERCENTAGE,
  HealthDataType.BODY_MASS_INDEX,
  HealthDataType.BODY_TEMPERATURE,
  HealthDataType.DIETARY_CARBS_CONSUMED,
  HealthDataType.DIETARY_ENERGY_CONSUMED,
  HealthDataType.DIETARY_FATS_CONSUMED,
  HealthDataType.DIETARY_PROTEIN_CONSUMED,
  HealthDataType.ELECTRODERMAL_ACTIVITY,
  HealthDataType.FORCED_EXPIRATORY_VOLUME,
  HealthDataType.HEART_RATE,
  HealthDataType.HEART_RATE_VARIABILITY_SDNN,
  HealthDataType.HEIGHT,
  HealthDataType.HIGH_HEART_RATE_EVENT,
  HealthDataType.IRREGULAR_HEART_RATE_EVENT,
  HealthDataType.LOW_HEART_RATE_EVENT,
  HealthDataType.RESTING_HEART_RATE,
  HealthDataType.STEPS,
  HealthDataType.WAIST_CIRCUMFERENCE,
  HealthDataType.WALKING_HEART_RATE,
  HealthDataType.WEIGHT,
  HealthDataType.FLIGHTS_CLIMBED,
  HealthDataType.DISTANCE_WALKING_RUNNING,
  HealthDataType.MINDFULNESS,
  HealthDataType.SLEEP_IN_BED,
  HealthDataType.SLEEP_AWAKE,
  HealthDataType.SLEEP_ASLEEP,
  HealthDataType.WATER,
  HealthDataType.EXERCISE_TIME,
  HealthDataType.WORKOUT,
  HealthDataType.HEADACHE_NOT_PRESENT,
  HealthDataType.HEADACHE_MILD,
  HealthDataType.HEADACHE_MODERATE,
  HealthDataType.HEADACHE_SEVERE,
  HealthDataType.HEADACHE_UNSPECIFIED,
  HealthDataType.ELECTROCARDIOGRAM,
];

/// List of data types available on Android
const List<HealthDataType> dataTypesAndroid = [
  HealthDataType.ACTIVE_ENERGY_BURNED,
  HealthDataType.BLOOD_OXYGEN,
  HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  HealthDataType.BLOOD_PRESSURE_SYSTOLIC,

  // HealthDataType.BODY_MASS_INDEX,
  HealthDataType.BODY_TEMPERATURE,
  HealthDataType.HEART_RATE,
  HealthDataType.STEPS,
  // HealthDataType.MOVE_MINUTES, // TODO: Find alternative for Health Connect
  HealthDataType.DISTANCE_DELTA,
  HealthDataType.SLEEP_DEEP,
  HealthDataType.SLEEP_LIGHT,
  HealthDataType.SLEEP_REM,
  HealthDataType.SLEEP_AWAKE,
];

class HealthDataUtils {
  void uploadData() async {
    //Fetch data from local DB

    bool dataShare = HealthDataUtils().checkDataSharePermission();
    if (dataShare) {
      HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
      final readings = await getIt<AppDatabase>()
          .healthReadingDao
          .getUnSynchedReadingsForHealth();
      // Reformat data
      // Health Data
      readings.forEach((element) async {
        if (element.MedicalCode == "HR") {
          await health.writeHealthData(element.ReadingMax,
              HealthDataType.HEART_RATE, element.TimeStamp, element.TimeStamp);
        }
        if (element.MedicalCode == "BT") {
          await health.writeHealthData(
              element.ReadingMax,
              HealthDataType.BODY_TEMPERATURE,
              element.TimeStamp,
              element.TimeStamp);
        }
        if (element.MedicalCode == "BP") {
          await health.writeBloodPressure(element.ReadingMax.toInt(),
              element.ReadingMin.toInt(), element.TimeStamp, element.TimeStamp);
        }
        if (element.MedicalCode == "OS") {
          double finalSPO2 = element.ReadingMax / 100;
          await health.writeHealthData(finalSPO2, HealthDataType.BLOOD_OXYGEN,
              element.TimeStamp, element.TimeStamp);
        }
      });
      //Activity Data
      final activityReadings = await getIt<AppDatabase>()
          .activityDetailsDao
          .getUnSynchedActivityForHealth(); // App is crashing here...08-June @ 6:56 pm.
      //Reformat data
      // Health Data
      activityReadings.forEach((element) async {
        if (element.ActivityType == "Step") {
          await health.writeHealthData(
              element.ActivityValue,
              HealthDataType.STEPS,
              element.ActivityStartDate,
              element.ActivityEndDate);
        }
        if (element.ActivityType == "Sleep") {
          if (element.ActivityValue < 10) {
            await health.writeHealthData(1, HealthDataType.SLEEP_DEEP,
                element.ActivityStartDate, element.ActivityEndDate);
          } else if (element.ActivityValue < 40) {
            await health.writeHealthData(1, HealthDataType.SLEEP_LIGHT,
                element.ActivityStartDate, element.ActivityEndDate);
          } else if (element.ActivityValue < 99) {
            await health.writeHealthData(1, HealthDataType.SLEEP_REM,
                element.ActivityStartDate, element.ActivityEndDate);
          } else if (element.ActivityValue < 255) {
            await health.writeHealthData(1, HealthDataType.SLEEP_AWAKE,
                element.ActivityStartDate, element.ActivityEndDate);
          }
        }
        if (element.ActivityType == "Calorie") {
          await health.writeWorkoutData(HealthWorkoutActivityType.WALKING,
              element.ActivityStartDate, element.ActivityEndDate,
              totalEnergyBurned: element.ActivityValue.toInt());
        }
        if (element.ActivityType == "Distance") {
          await health.writeHealthData(
              element.ActivityValue,
              HealthDataType.DISTANCE_DELTA,
              element.ActivityStartDate,
              element.ActivityEndDate);
        }
      });
    }
  }

  void setDataSharePermission(bool value) async {
    getIt<SharedPreferences>().setBool("setDataSharePermission", value);
  }

  bool checkDataSharePermission() {
    bool isDataSharedPermitted =
        getIt<SharedPreferences>().getBool("setDataSharePermission") ?? false;
    return isDataSharedPermitted;
  }
}
