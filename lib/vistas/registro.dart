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
      body: Stack(children: <Widget>[
         Container(
          margin: EdgeInsets.only(top: 110, left: 20),
          width: double.infinity,
          decoration:
          BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Text(
            "Crea tu cuenta",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 60, color: Color(0xff082652)),
            textScaleFactor: 0.5,
          ),

        ),
        Transform.translate(offset:
        Offset(0,-80),
            child: Center(
            child: SingleChildScrollView(
            child: Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
            margin:
            const EdgeInsets.only(left: 20, right: 20, top: 260),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff082652),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),


              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "¿Ya tienes una cuenta?",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Registro()));
                      },
                      child: Text("Inicia sesión"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ],
                )
              ],
              ),
              ),

              ),)

                ),
              ),
              ),
              ]),
              );
            }
          }