import 'package:ahorra_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/usuario.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  late DatabaseReference dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('usuarios');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 110, left: 20),
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: const Text(
            "Crea tu cuenta",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Color(0xff082652)),
            textScaleFactor: 0.5,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -80),
          child: Center(
            child: SingleChildScrollView(
                child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ingresa tu nombre';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                        ),
                      ),
                      TextFormField(
                        controller: _telefonoController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ingresa tu telefono';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Telefono',
                        ),
                      ),
                      TextFormField(
                        controller: _correoController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ingresa un correo electronico';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Correo electronico',
                        ),
                      ),
                      TextFormField(
                        controller: _contrasenaController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ingrese una contraseña';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Usuario usuario = Usuario(
                                nombre: _nombreController.text,
                                correo: _correoController.text,
                                telefono: _telefonoController.text,
                              );
                              dbRef.push().set(usuario.toMap());
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _correoController.text,
                                      password: _contrasenaController.text)
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()));
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff082652),
                            fixedSize: const Size(300, 50),
                            textStyle: const TextStyle(
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: const Text('CREAR CUENTA'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "¿Ya tienes una cuenta?",
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Registro()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            child: const Text("Inicia sesión"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      ]),
    );
  }
}
