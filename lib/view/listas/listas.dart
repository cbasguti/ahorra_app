import 'package:ahorra_app/model/listado.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas_detalles.dart';

import 'package:flutter/material.dart';

import '../../widget/check_lista.dart';
import '../../widget/sidebar.dart';
import '../home/home.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
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
                ),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25.0),
          FutureBuilder<int>(
            future: dbService.getListCount(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tienes ${snapshot.data} listas guardadas',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: 'Overpass',
                    ),
                  ),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  nombreLista,
                                  style: TextStyle(
                                    color: Color(0xFF254587),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Overpass',
                                  ),
                                ),
                                subtitle: FutureBuilder<String>(
                                  future:
                                      dbService.getProductsPrice(nombreLista),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      total = snapshot.data!;
                                      return Text(
                                        'Total: ${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: 'Overpass',
                                        ),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                leading: Image.network(imgUrl),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  width: 100,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListasDetalles(
                                                    lista: nombreLista,
                                                    precioTotal: total,
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      primary: Color(0xFF254587),
                                    ),
                                    child: Text('Editar'),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 100,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ListaCheck(
                                            lista: nombreLista,
                                            precioTotal: total,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      primary: Color(0xFF309E43),
                                    ),
                                    child: Text('Comenzar'),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ],
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
