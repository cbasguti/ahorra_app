import 'package:ahorra_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
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
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> usuarios = {
                        'nombre': _nombreController.text,
                        'telefono': _telefonoController.text,
                        'correo': _correoController.text,
                        'contraseña': _contrasenaController.text,
                      };
                      dbRef.push().set(usuarios);
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _correoController.text,
                          password: _contrasenaController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const MyApp()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    }
                  },
                  child: Text('Registrarse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}