import 'dart:async';

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
          print(value['nombre']);
        }
      });

      String userIdNew = userId.split(" ")[0];
      return userIdNew;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0 * 2.5),
      // It will cover 20% of our total height
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 36 + 20.0,
            ),
            height: size.height * 0.2 - 27,
            decoration: const BoxDecoration(
              color: Color(0xFF254587),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                FutureBuilder<String>(
                  future: getUsername(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Hola, ' + (snapshot.data ?? 'error'),
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                const Spacer(),
                Image.asset("assets/image/logo.png")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xFF254587).withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Busca aquí tus productos",
                        hintStyle: TextStyle(
                          color: Color(0xFF254587).withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                 Icon(Icons.search),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
