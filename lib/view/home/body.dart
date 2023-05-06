import 'package:ahorra_app/view/home/home_buscar.dart';
import 'package:ahorra_app/view/home/home_categorias.dart';
import 'package:ahorra_app/view/home/home_marcas.dart';
import 'package:ahorra_app/view/home/home_ofertas.dart';
import 'package:ahorra_app/view/home/home_seccion.dart';
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
