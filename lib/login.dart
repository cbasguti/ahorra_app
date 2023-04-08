import 'package:ahorra_app/vistas/home/home.dart';
import 'package:ahorra_app/vistas/registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          style: TextStyle(fontSize: 60, color: Color(0xff082652)),
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
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                        .then((value) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => MenuPrincipal()));
                                    }).onError((error, stackTrace) {
                                      print("Error ${error.toString()}");
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff082652),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                child: const Text("Iniciar sesión"),
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
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Registro()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)),
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
