import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/listas/listas_vacia.dart';
import 'package:flutter/material.dart';

class ListasPopUp extends StatefulWidget {
  const ListasPopUp({
    Key? key,
    required this.producto,
    required this.cantidad,
  }) : super(key: key);

  final Producto producto;
  final int cantidad;

  @override
  ListasPopUpState createState() => ListasPopUpState();
}

class ListasPopUpState extends State<ListasPopUp> {
  bool listCreated = false;
  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _dbService.getLists(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              _dbService.getLists();
              if (snapshot.data!.isEmpty && listCreated == false) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaTest()),
                );
                listCreated = true;
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Selecciona una lista'),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _dbService.addProductoToLista(
                                    snapshot.data![index].toString(),
                                    widget.producto,
                                    widget.cantidad);
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      content:
                                          Text('Producto añadido con éxito'),
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index].toString()),
                                subtitle: const Text('Descripción de la lista'),
                                leading: Image.network(
                                    'https://i.ibb.co/6t98mmT/lista-de-deseos.png'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: const Text(
              'Añadir a una lista',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF254587),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
