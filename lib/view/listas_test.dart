import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas.dart';
import 'package:flutter/material.dart';

class ListaTest extends StatefulWidget {
  const ListaTest({super.key});

  @override
  ListaTestState createState() => ListaTestState();
}

class ListaTestState extends State<ListaTest> {
  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Mis Listas', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '¡Aún no tienes listas!',
                    style: TextStyle(
                      fontFamily: 'Overpass',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF090F47),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Usa el botón crear nueva lista para empezar a ahorrar',
                    style: TextStyle(
                      fontFamily: 'Overpass',
                      fontSize: 16,
                      color: Color(0x73090F47),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String nuevaLista = '';

                    return AlertDialog(
                      title: const Text('Crear nueva lista'),
                      content: TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Nombre de la lista'),
                        onChanged: (value) {
                          nuevaLista = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            dbService.crearNuevaLista(nuevaLista);
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Listas()),
                            );
                          },
                          child: const Text('Crear'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Overpass',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                fixedSize: const Size(100, 40),
              ),
              child: const Text('CREAR UNA LISTA'),
            ),
          ],
        ),
      ),
    );
  }
}
