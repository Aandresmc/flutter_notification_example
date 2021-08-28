import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppContainer());
}
