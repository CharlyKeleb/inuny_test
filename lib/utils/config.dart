
import 'package:firebase_core/firebase_core.dart';
import 'package:inuny_test/firebase_options.dart';

class Config {
  static initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
