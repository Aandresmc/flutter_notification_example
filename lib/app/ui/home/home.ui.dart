import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/services/local_notifications.dart';
import 'package:flutter_push_notification/app/services/push_notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await LocalNotificationService.initialize(context);

      PushNotificationService.notificationStream.listen((notification) {
        print('notification: ${notification.data}');
        if (notification.data['route'] != null) {
          Navigator.of(context).pushNamed(notification.data["route"], arguments: notification.data);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
