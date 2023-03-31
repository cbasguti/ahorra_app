import 'package:flutter/material.dart';

import 'nuestras_marcas.dart';
import 'header_con_busqueda.dart';
import 'ofertas_del_dia.dart';
import 'titulo_y_boton.dart';
import 'categorias_destacadas.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderConBusqueda(size: size),
          TituloYBoton(titulo: "Categorias destacadas", press: () {}),
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
