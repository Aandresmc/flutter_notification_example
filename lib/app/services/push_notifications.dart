import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notifications.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<RemoteMessage> _notificationStream = new StreamController.broadcast();
  static Stream<RemoteMessage> get notificationStream => _notificationStream.stream;

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    await requestPermission();

    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    //   if (message != null) {
    //     print('getInitialMessage data: ${message.data}');
    //     Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
    //   }
    // });
  }

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    print('User push notification status ${settings.authorizationStatus}');
  }

  static Future _backgroundHandler(RemoteMessage message) async {
    print('_backgroundHandler ${message.data}');
    _notificationStream.add(message);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('_onMessageHandler ${message.data}');
    _notificationStream.add(message);
    LocalNotificationService.display(message);
    // Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('_onMessageOpenApp ${message.data}');
    _notificationStream.add(message);
  }

  static closeStreams() {
    _notificationStream.close();
  }
}
