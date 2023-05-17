import 'package:ahorra_app/service/firebase_options.dart';
import 'package:ahorra_app/view/home/home.dart';
import 'package:ahorra_app/view/screen/screen_splash.dart';
import 'package:ahorra_app/widget/sidebar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Verificar el estado de inicio de sesión almacenado en shared_preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Navegar a la pantalla adecuada según el estado de inicio de sesión
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

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
      home: isLoggedIn
          ? Stack(
              children: const [
                MenuLateral(),
                MenuPrincipal(),
              ],
            )
          : const SplashScreen(),
    );
  }
}
