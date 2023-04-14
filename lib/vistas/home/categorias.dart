import 'package:flutter/material.dart';

class CategoriasDestacadas extends StatelessWidget {
  const CategoriasDestacadas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Categoria(
            imagen: "assets/image/menu/categorias/lacteos.png",
            titulo: "Lacteos",
            press: () {},
          ),
          Categoria(
            imagen: "assets/image/menu/categorias/frutas.png",
            titulo: "Frutas",
            press: () {},
          ),
          Categoria(
            imagen: "assets/image/menu/categorias/carnes.png",
            titulo: "Carnes",
            press: () {},
          ),
          Categoria(
            imagen: "assets/image/menu/categorias/aseo.png",
            titulo: "Aseo",
            press: () {},
          ),
          Categoria(
            imagen: "assets/image/menu/categorias/panaderia.png",
            titulo: "Panaderia",
            press: () {},
          ),
          Categoria(
            imagen: "assets/image/menu/categorias/cereales.png",
            titulo: "Cereales",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class Categoria extends StatelessWidget {
  const Categoria({
    Key? key,
    required this.imagen,
    required this.titulo,
    required this.press,
  }) : super(key: key);

  final String imagen;
  final String titulo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
      //onTap: press,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              top: 20.0 / 2,
              bottom: 20.0 / 2,
            ),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                //fit: BoxFit.cover,
                image: AssetImage(imagen),
              ),
            ),
          ),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}





