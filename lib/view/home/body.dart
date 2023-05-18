import 'package:ahorra_app/view/home/home_buscar.dart';
import 'package:ahorra_app/view/home/home_categorias.dart';
import 'package:ahorra_app/view/home/home_marcas.dart';
import 'package:ahorra_app/view/home/home_ofertas.dart';
import 'package:ahorra_app/view/home/home_seccion.dart';
import 'package:ahorra_app/widget/check_lista.dart';
import 'package:flutter/material.dart';

import '../../widget/lista_categorias.dart';
import '../../widget/check_lista.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderConBusqueda(size: size),
          TituloYBoton(
            titulo: "Categorias",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaCategorias(),
                ),
              );
            },
          ),
          const CategoriasDestacadas(),
          TituloYBoton(
            titulo: "CHECK",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaCheck(),
                ),
              );
            },
          ),
          const OfertasDelDia(),
          TituloYBoton(titulo: "Nuestras Marcas", press: () {}),
          const NuestrasMarcas(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
