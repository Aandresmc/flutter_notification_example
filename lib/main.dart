import 'package:flutter/material.dart';

import 'app/app.container.dart';
import 'app/core/notification/push_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(const AppContainer());
}
