// routes app
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/ui/home/home.ui.dart';
import 'package:flutter_push_notification/app/ui/message/message.ui.dart';

import 'app.routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case AppRoutes.messageScreen:
        return MaterialPageRoute(builder: (_) => MessageScreen(arguments: args as Map<String, dynamic>));

      default:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
    }
  }
}
