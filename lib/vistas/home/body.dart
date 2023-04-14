import 'package:flutter/material.dart';

import 'marcas.dart';
import 'buscar.dart';
import 'ofertas.dart';
import 'seccion.dart';
import 'categorias.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderConBusqueda(size: size),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TituloConInterlineado(texto: "Categorías"),
          ),
          CategoriasDestacadas(),
          TituloYBoton(titulo: "Ofertas del día", press: () {}),
          OfertasDelDia(),
          TituloYBoton(titulo: "Nuestras Marcas", press: () {}),
          NuestrasMarcas(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
