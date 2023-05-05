import 'dart:ffi';

import 'package:ahorra_app/vistas/listas_detalles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_app/listado.dart';
import 'package:ahorra_app/main.dart';

import '../database_service.dart';

class Listas extends StatefulWidget {
  @override
  _ListasState createState() => _ListasState();
}

class _ListasState extends State<Listas> {
  @override
  Widget build(BuildContext context) {
    Future<int> getLists() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String? userEmail = user?.email;
      final dbService = DatabaseService();
      final nListas = await dbService.getListsCount(userEmail!);
      return nListas;
    }

    Future<List> getListObject() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String? userEmail = user?.email;
      final dbService = DatabaseService();
      final listas = await dbService.getLists(userEmail!);
      return listas;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25.0),
          FutureBuilder<int>(
            future: getLists(),
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
            future: getListObject(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      getLists();
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
                                    builder: (context) => ListasDetalles()));
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
