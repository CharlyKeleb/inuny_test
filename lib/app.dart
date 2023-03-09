import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inuny_test/theme/theme.dart';
import 'package:inuny_test/utils/providers.dart';
import 'package:inuny_test/views/auth/login.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'InunyTest',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        home: const Login(),
      ),
    );
  }
}

// Apply font to our app's theme
ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.interTextTheme(
      theme.textTheme,
    ),
  );
}
