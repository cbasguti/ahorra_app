import 'package:ahorra_app/service/firebase_options.dart';
import 'package:ahorra_app/view/screen/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF254587,
          <int, Color>{
            50: Color(0xFFE1E6ED),
            100: Color(0xFFB3C2D6),
            200: Color(0xFF809EBD),
            300: Color(0xFF4D7AA4),
            400: Color(0xFF255E8F),
            500: Color(0xFF254587),
            600: Color(0xFF223F7D),
            700: Color(0xFF1E3773),
            800: Color(0xFF1A2F69),
            900: Color(0xFF122259),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
