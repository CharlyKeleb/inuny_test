import 'package:flutter/material.dart';
import 'package:inuny_test/app.dart';
import 'package:inuny_test/utils/config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();

  runApp(const MyApp());
}
