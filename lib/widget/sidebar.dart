import 'package:ahorra_app/service/auth/auth_service.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas.dart';
import 'package:ahorra_app/view/listas/listas_vacia.dart';
import 'package:ahorra_app/view/screen/screen_welcome.dart';
import 'package:ahorra_app/widget/informacion.dart';
import 'package:ahorra_app/widget/contactanos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  MenuLateralState createState() => MenuLateralState();
}

class MenuLateralState extends State<MenuLateral> {
  final _dbService = DatabaseService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    bool listCreated = false;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/image/user.png'),
                    height: 80,
                    width: 80,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: _dbService.getUsername(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              (snapshot.data ?? 'error'),
                              style: const TextStyle(
                                color: Color(0xFF082652),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Text(
                        'Este es tu perfil',
                        style: TextStyle(
                          color: Colors.grey[400], // Color gris claro
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InformacionScreen()),
                    );
                  },
                  child: const NewRow(
                    text: 'Información',
                    icon: Icons.info_outline,
                  ),
                ),
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 2),
                const SizedBox(height: 6),
                FutureBuilder<int>(
                  future: _dbService.getListCount(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          _dbService.getListCount();
                          if (snapshot.data == 0 && listCreated == false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ListaTest()),
                            );
                            listCreated = true;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Listas()),
                            );
                          }
                        },
                        child: const NewRow(
                          text: 'Mis Listas',
                          icon: Icons.bookmark_border,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                /*
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 1),
                const SizedBox(height: 6),
                const NewRow(
                  text: 'Preguntas',
                  icon: Icons.question_mark_outlined,
                ),
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 1),
                const SizedBox(height: 6),
                NewRow(
                  text: 'Favoritos',
                  icon: Icons.favorite_border,
                ),
                */
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 2),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConctactanosScreen()),
                    );
                  },
                  child: const NewRow(
                    text: 'Contactanos',
                    icon: Icons.comment,
                  ),
                ),
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 2),
                const SizedBox(height: 6),
                const NewRow(
                  text: 'Configuración',
                  icon: Icons.settings,
                ),
                const SizedBox(height: 6),
                Divider(color: Colors.grey[300], thickness: 2),
                const SizedBox(height: 6),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.cancel,
                  color: Color.fromRGBO(9, 28, 63, 0.75),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                  ),
                  onPressed: () {
                    _authService.cerrarSesion().then((value) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      if (kDebugMode) {
                        print("Signed Out");
                      }
                      SystemNavigator.pop(); // Cerrar la aplicación
                    });
                  },
                  child: const Text(
                    'Cerrar Sesion',
                    style: TextStyle(color: Color.fromRGBO(9, 28, 63, 0.75)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: const Color.fromRGBO(9, 28, 63, 0.75),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(text,
            style: const TextStyle(
              fontFamily: 'Overpass',
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              height: 1.33,
              letterSpacing: -0.24,
              color: Color.fromRGBO(9, 28, 63, 0.75),
            ))
      ],
    );
  }
}
