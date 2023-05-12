import 'package:ahorra_app/model/listado.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas_detalles.dart';

import 'package:flutter/material.dart';

class Listas extends StatefulWidget {
  const Listas({super.key});

  @override
  ListasState createState() => ListasState();
}

class ListasState extends State<Listas> {
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
      body: Column(
        children: [
          const SizedBox(height: 25.0),
          FutureBuilder<int>(
            future: dbService.getListCount(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                      'Tiene un total de ${snapshot.data} listas guardadas'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<Listado>>(
            future: dbService.getListados(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Listado>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      dbService.getListados();
                      String nombreLista =
                          snapshot.data![index].nombre.toString();
                      String imgUrl = snapshot.data![index].imagen.toString();
                      late String total;
                      return Card(
                        child: ListTile(
                          title: Text(nombreLista),
                          subtitle: FutureBuilder<String>(
                            future: dbService.getProductsPrice(nombreLista),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                total = snapshot.data!;
                                return Text('Total: ${snapshot.data}');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          leading: Image.network(imgUrl),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListasDetalles(
                                          lista: nombreLista,
                                          precioTotal: total,
                                        )));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
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
                      decoration:
                          const InputDecoration(hintText: 'Nombre de la lista'),
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
              fixedSize: const Size(300, 40),
            ),
            child: const Text('CREAR UNA LISTA'),
          ),
        ],
      ),
    );
  }
}
