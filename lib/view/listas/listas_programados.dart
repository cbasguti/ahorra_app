import 'package:ahorra_app/model/listado.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas_detalles.dart';

import 'package:flutter/material.dart';

class ListasProgram extends StatefulWidget {
  const ListasProgram({super.key});

  @override
  ListasState2 createState() => ListasState2();
}

class ListasState2 extends State<ListasProgram> {
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
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(nombreLista),
                                subtitle: FutureBuilder<String>(
                                  future: dbService.getProductsPrice(nombreLista),
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      total = snapshot.data!;
                                      return Text('Total: ${snapshot.data}');
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
                                ButtonTheme(

                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Ajusta el radio de los bordes según tus necesidades
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Lógica para editar
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Ajusta el tamaño de padding según tus necesidades
                                      primary: Color(0xFF254587), // Color de fondo del botón de "Editar"
                                    ),
                                    child: Text('Editar'),
                                  ),
                                ),
                                SizedBox(height: 0.5), // Ajusta el valor según tus necesidades para reducir el espacio entre los botones
                                ButtonTheme(

                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Ajusta el radio de los bordes según tus necesidades
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Lógica para comenzar
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Ajusta el tamaño de padding según tus necesidades
                                      primary: Color(0xFF309E43), // Color de fondo del botón de "Comenzar"
                                    ),
                                    child: Text('Comenzar'),
                                  ),
                                ),
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