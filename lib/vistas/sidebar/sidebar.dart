import 'package:ahorra_app/start/welcome.dart';
import 'package:ahorra_app/vistas/listas_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../database_service.dart';
import '../listas.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  MenuLateralState createState() => MenuLateralState();
}

class MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    bool listCreated = false;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? userEmail = user?.email;
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('usuarios');
    String userId = 'Usuario';

    Future<String> getUsername() async {
      final snapshot = await dbRef.get();
      final values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (value['correo'] == userEmail) {
          userId = value['nombre'];
        }
      });

      String userIdNew = userId;
      return userIdNew;
    }

    Future<int> getLists() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String? userEmail = user?.email;
      final dbService = DatabaseService();
      final count = await dbService.getListsCount(userEmail!);
      return count;
    }

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
                  future: getUsername(),
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
                  future: getLists(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          getLists();
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
                    FirebaseAuth.instance.signOut().then((value) {
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
