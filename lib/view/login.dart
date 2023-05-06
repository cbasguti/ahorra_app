import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../vistas/Sidebar/sidebar.dart';
import '../widget/registro.dart';
import 'home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 150),
        width: double.infinity,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: const Text(
          "¡Bienvenido de vuelta!",
          textAlign: TextAlign.center,
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
                          borderRadius: BorderRadius.circular(20)),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 260),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 15,
                                    color: Color(0xff082652)),
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese su correo electrónico';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Correo electrónico',
                                ),
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 15,
                                    color: Color(0xff082652)),
                                controller: _passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese su contraseña';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: 'Contraseña',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text)
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Scaffold(
                                                    body: Stack(
                                                      children: const [
                                                        MenuLateral(),
                                                        MenuPrincipal(),
                                                      ],
                                                    ),
                                                  )));
                                    }).onError((error, stackTrace) {
                                      if (kDebugMode) {
                                        print("Error ${error.toString()}");
                                      }
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
                                child: const Text("INICIAR SESIÓN"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "¿Todavia no tienes una cuenta?",
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Registro()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    child: const Text("Registrate"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )))))
    ]));
  }
}
