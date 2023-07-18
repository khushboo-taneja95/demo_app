import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/features/main/data/models/notifications_model.dart';
import 'package:tres_connect/features/main/presentation/notification/bloc/notification_bloc.dart';
import 'package:tres_connect/navigation_service.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'general_notifications', // id
    'General Notifications', // title
    description:
        'This channel is used for important notifications regarding latest features and offers.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeFirebase() async {
  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (response) =>
        onSelectNotification(response.payload),
    onDidReceiveBackgroundNotificationResponse: (response) =>
        onSelectNotification(response.payload),
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    // TODO: handle the received notifications
  } else {
    print('User declined or has not accepted permission');
  }

  messaging.getToken().then((value) {
    String? token = value;
    debugPrint("Firebase token: $token");
    if (token != null) {
      getIt<SharedPreferences>().setString("device_token", token);
    }
  });
  // Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(
        'A new onMessageOpenedApp event was published! data: ${message.data} notification: ${message.notification}');
    getIt<NavigationService>().navigateTo(Routes.notification);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final data = message.data;
    showNotification(message);
    NotificationList notificationModel = NotificationList();
    String uid = data['uid'] ?? '';
    String notificationId = data['notificationid'] ?? '';
    String clickAction = data['click_action'] ?? '';
    String urlImageString = data['urlImageString'] ?? '';
    String targetPage = data['target_page'] ?? '';
    String notificationType = data['notification_type'] ?? '';

    notificationModel.isSeen = false;
    notificationModel.notificationId = notificationId;
    notificationModel.notificationTitle = data['title'] ?? '';
    notificationModel.notificationMessage = data['body'] ?? '';
    notificationModel.notificationType = notificationType;
    notificationModel.notificationImage = urlImageString;
    notificationModel.notificationData = data['data'] ?? '';
    notificationModel.appTarget = data['target_page'] ?? '1';
    notificationModel.targetPlatform = '1';
    notificationModel.notificationId = notificationId;
    notificationModel.notificationTime =
        DateTime.now().toUtc().toIso8601String();

    try {
      final pref = await SharedPreferences.getInstance();
      String? deviceAddress = pref.getString("device_address");
      if (deviceAddress != null && deviceAddress.isNotEmpty) {}
      await getIt<AppDatabase>()
          .notificationDao
          .insertNotification(notificationModel);
      BlocProvider.of<NotificationBloc>(
              getIt<NavigationService>().navigatorKey.currentContext!)
          .add(const NotificationLoadEvent(fetchFromRemote: true));
    } catch (e) {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      await database.notificationDao.insertNotification(notificationModel);
      print(e.toString());
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  debugPrint("Firebase initialized");
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  final data = message.data;
  final pref = await SharedPreferences.getInstance();
  String? deviceAddress = pref.getString("device_address");
  if (deviceAddress != null && deviceAddress.isNotEmpty) {}

  showNotification(message);
  NotificationList notificationModel = NotificationList();
  String uid = data['uid'] ?? '';
  String notificationId = data['notificationid'] ?? '';
  String clickAction = data['click_action'] ?? '';
  String urlImageString = data['urlImageString'] ?? '';
  String targetPage = data['target_page'] ?? '';
  String notificationType = data['notification_type'] ?? '';

  notificationModel.isSeen = false;
  notificationModel.notificationId = notificationId;
  notificationModel.notificationTitle = data['title'] ?? '';
  notificationModel.notificationMessage = data['body'] ?? '';
  notificationModel.notificationType = notificationType;
  notificationModel.notificationImage = urlImageString;
  notificationModel.notificationData = data['data'] ?? '';
  notificationModel.appTarget = data['target_page'] ?? '1';
  notificationModel.targetPlatform = '1';
  notificationModel.notificationId = notificationId;
  notificationModel.notificationTime = DateTime.now().toUtc().toIso8601String();

  try {
    await getIt<AppDatabase>()
        .notificationDao
        .insertNotification(notificationModel);
    BlocProvider.of<NotificationBloc>(
            getIt<NavigationService>().navigatorKey.currentContext!)
        .add(const NotificationLoadEvent(fetchFromRemote: true));
  } catch (e) {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    await database.notificationDao.insertNotification(notificationModel);
    print(e.toString());
  }
  print("Handling a background message: ${message.messageId}");
}

void showNotification(RemoteMessage message) async {
  final notificationData = message.data;

  String? largeImagePath;
  if ((notificationData['urlImageString'] as String).isNotEmpty) {
    largeImagePath = await _downloadAndSaveFile(
        notificationData['urlImageString'], "largeIcon.png");
  }
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'general_notifications', 'General Notifications',
          channelDescription:
              'This channel is used for important notifications regarding latest features and offers.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          styleInformation: largeImagePath != null
              ? BigPictureStyleInformation(
                  FilePathAndroidBitmap(largeImagePath))
              : null,
          ticker: 'ticker');
  DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails();
  NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: darwinNotificationDetails);
  int notificationId = 0;
  try {
    notificationId = int.parse(notificationData['notificationid']);
  } catch (e) {
    notificationId = 0;
  }
  await flutterLocalNotificationsPlugin.show(notificationId,
      notificationData['title'], notificationData['body'], notificationDetails);
}

Future<dynamic> onSelectNotification(payload) async {
  debugPrint("Navigating. Payload: $payload");
  BlocProvider.of<NotificationBloc>(
          getIt<NavigationService>().navigatorKey.currentContext!)
      .add(const NotificationLoadEvent(fetchFromRemote: true));
  getIt<NavigationService>().navigateTo(Routes.notification);
}

Future<String?> _downloadAndSaveFile(String url, String fileName) async {
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final resp = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(resp.data);
    print("Img file path: $filePath");
    return filePath;
  } catch (e) {
    return null;
  }
}
