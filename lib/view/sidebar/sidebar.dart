import 'package:ahorra_app/service/auth/auth_service.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas.dart';
import 'package:ahorra_app/view/listas/listas_vacia.dart';
import 'package:ahorra_app/view/screen/screen_welcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      color: Colors.grey.shade500,
      child: Padding(
        padding: const EdgeInsets.only(top: 200, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/usuario.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FutureBuilder<String>(
                  future: _dbService.getUsername(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        (snapshot.data ?? 'error'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const NewRow(
                  text: 'Perfil',
                  icon: Icons.person_outline,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 20,
                ),
                const NewRow(
                  text: 'Preguntas',
                  icon: Icons.question_mark_outlined,
                ),
                const SizedBox(
                  height: 20,
                ),
                const NewRow(
                  text: 'Favoritos',
                  icon: Icons.favorite_border,
                ),
                const SizedBox(
                  height: 20,
                ),
                const NewRow(
                  text: 'Programados',
                  icon: Icons.alarm,
                ),
                const SizedBox(
                  height: 20,
                ),
                const NewRow(
                  text: 'Configuración',
                  icon: Icons.settings,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text(
                    'Cerrar Sesion',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _authService.cerrarSesion().then((value) {
                      if (kDebugMode) {
                        print("Signed Out");
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()));
                    });
                  },
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
          color: Colors.white,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
