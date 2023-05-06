import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../producto/lista_productos.dart';

class OfertasDelDia extends StatelessWidget {
  const OfertasDelDia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nProductos = 0;

    Future<int> getProducts() async {
      final dbProductos =
          FirebaseDatabase.instance.ref().child('productos').child('Ofertas');
      dbProductos.once().then((event) {
        nProductos = event.snapshot.children.length;
      });
      return nProductos;
    }

    getProducts();

    Future<Map<String, dynamic>> getDetails(childN) async {
      final dbRef = FirebaseDatabase.instance
          .ref()
          .child('productos')
          .child('Ofertas')
          .child(childN);
      final snapshot = await dbRef.get();
      final values = snapshot.value as Map<dynamic, dynamic>;
      final detalles = <String, dynamic>{};
      values.forEach((key, value) {
        if (key == 'nombre') {
          detalles['nombre'] = value;
        } else if (key == 'image_path') {
          detalles['image_path'] = value;
        } else if (key == 'precios') {
          detalles['precio'] = value['euro'];
        }
      });
      return detalles;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return FutureBuilder<Map<String, dynamic>>(
            future: getDetails(index.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Productos(
                  imagen: snapshot.data?['image_path'] ?? '',
                  nombre: snapshot.data?['nombre'] ?? '',
                  tienda: "Exito",
                  precio: snapshot.data?['precio'] ?? 0,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        }),
      ),
    );
  }
}
