import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tres_connect/main.dart';
import 'package:workmanager/workmanager.dart';

FlutterBackgroundService? service;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  service.on("stopService").listen((event) async {
    await service.stopSelf();
    debugPrint('Service stopped');
  });
}

Future<bool> onBackground(ServiceInstance service) {
  print("Service is running in background");
  return Future.value(true);
}

Future<bool> onForeground(ServiceInstance service) {
  print("Service is running in foreground");
  return Future.value(true);
}

Future<void> initializeService() async {
  // service = FlutterBackgroundService();

  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   "band_connection_notification", // id
  //   'Band Connection', // title
  //   description:
  //       'This channel is to display connection status of the watch.', // description
  //   importance: Importance.high, // importance must be at low or higher level
  // );

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await service?.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will be executed when app is in foreground or background in separated isolate
  //       onStart: onStart,
  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //       autoStartOnBoot: true,
  //       notificationChannelId:
  //           "band_connection_notification", // this must match with notification channel you created above.
  //       initialNotificationTitle: 'Tres Connect',
  //       initialNotificationContent: 'Band is connected',
  //       foregroundServiceNotificationId: 123456,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       autoStart: true,
  //       onBackground: onBackground,
  //       onForeground: onForeground,
  //     ));
}

Future<void> stopService() async {
  // if (await service?.isRunning() ?? false) {
  //   service!.invoke("stopService");
  // }
}
