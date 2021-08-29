import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_push_notification/app/shared/routes/route.generator.dart';

import 'core/notification/local_notifications.dart';
import 'core/notification/push_notifications.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());

    useEffect(() {
      Future.microtask(() async {
        await LocalNotificationService.initialize(_navigatorKey);

        PushNotificationService.notificationStream.listen((notification) {
          print('notification: ${notification.data}');
        });
      });
    }, []);

    return MaterialApp(
      title: 'example notifications',
      initialRoute: '/',
      navigatorKey: _navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
