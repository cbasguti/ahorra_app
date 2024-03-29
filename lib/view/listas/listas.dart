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
          FutureBuilder<List>(
            future: dbService.getLists(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      dbService.getLists();
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index].toString()),
                          subtitle: const Text('Precio total:\$10.000'),
                          leading: Image.network(
                              'https://i.ibb.co/6t98mmT/lista-de-deseos.png'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListasDetalles(
                                        lista:
                                            snapshot.data![index].toString())));
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
        ],
      ),
    );
  }
}
