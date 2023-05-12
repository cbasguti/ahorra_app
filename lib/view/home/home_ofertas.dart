import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/producto/producto_lista.dart';
import 'package:flutter/material.dart';

class OfertasDelDia extends StatelessWidget {
  const OfertasDelDia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return FutureBuilder<List<Producto>>(
            future: dbService.getDetails(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
              if (snapshot.hasData) {
                return ProductosCard(
                  producto: snapshot.data![index],
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
