import 'package:ahorra_app/vistas/listas_detalles.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_app/listado.dart';
import 'package:ahorra_app/main.dart';

class Listas extends StatefulWidget {
  @override
  _ListasState createState() => _ListasState();
}

class _ListasState extends State<Listas> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Column(
        children: [
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.all(3.0),
            child: Text('Tiene un total de ${Listadolist.length} listas guardadas'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Listadolist.length,
              itemBuilder: (context, index) {
                Listado listado = Listadolist[index];
                return Card(
                  child: ListTile(
                    title: Text(listado.nombre),
                    subtitle: Text('Precio total:${listado.precio}'),
                    leading: Image.network(listado.imagen),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListasDetalles(listado)));

                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  }



