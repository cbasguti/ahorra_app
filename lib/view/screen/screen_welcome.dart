import 'package:ahorra_app/view/auth/auth_login.dart';
import 'package:ahorra_app/view/auth/auth_registro.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/image/start/compradora.png',
              ),
            ),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '¡Te damos la bienvenida!',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF090F47),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '¿Quieres un poco de ayuda para ahorrar y ser más eficiente?',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 16,
                        color: Color(0x73090F47),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Registro(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        fixedSize: const Size(300, 10),
                      ),
                      child: const Text('REGISTRARSE CON CORREO'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/image/start/logo_facebook.png',
                        height: 24,
                      ),
                      label: const Text('CONTINUAR CON FACEBOOK'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF090F47),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1, color: Colors.grey),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        fixedSize: const Size(300, 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/image/start/logo_google.png',
                        height: 24,
                      ),
                      label: const Text('CONTINUAR CON GMAIL'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF090F47),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1, color: Colors.grey),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        fixedSize: const Size(300, 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
