import 'dart:async';

import 'package:ahorra_app/view/producto/producto_lista.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderConBusqueda extends StatelessWidget {
  const HeaderConBusqueda({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Obtener el usuario actualmente autenticado
    final User? user = auth.currentUser;

    // Obtener el correo electrónico del usuario actual
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

      String userIdNew = userId.split(" ")[0];
      return userIdNew;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15.0 * 2.5),
      child: SizedBox(
        height: size.height * 0.2 + 20,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20 + 20.0,
              ),
              height: size.height * 0.2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF082652), Color(0xFF3E61B9)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Row(
                children: <Widget>[
                  FutureBuilder<String>(
                    future: getUsername(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/image/user.png'),
                              radius: 28.0,
                            ),
                            Text(
                              'Hola, ${snapshot.data ?? 'error'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Overpass'),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  const Spacer(),
                  Image.asset("assets/image/menu/moneda.png")
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: const Color(0xFF082652).withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListaProductos(collectionName: 'Todos los productos'),
                            ),
                          );
                        },
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Busca aquí tus productos",
                          hintStyle: TextStyle(
                            color: const Color(0xFF254587).withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
