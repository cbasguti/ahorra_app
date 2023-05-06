import 'package:ahorra_app/view/home/buscar.dart';
import 'package:ahorra_app/view/home/categorias.dart';
import 'package:ahorra_app/view/home/marcas.dart';
import 'package:ahorra_app/view/home/ofertas.dart';
import 'package:ahorra_app/view/home/seccion.dart';
import 'package:flutter/material.dart';

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TituloConInterlineado(texto: "Categorías"),
          ),
          const CategoriasDestacadas(),
          TituloYBoton(titulo: "Ofertas del día", press: () {}),
          const OfertasDelDia(),
          TituloYBoton(titulo: "Nuestras Marcas", press: () {}),
          const NuestrasMarcas(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
