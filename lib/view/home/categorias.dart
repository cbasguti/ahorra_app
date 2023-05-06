import 'package:ahorra_app/view/producto/lista_productos.dart';
import 'package:flutter/material.dart';

class CategoriasDestacadas extends StatelessWidget {
  const CategoriasDestacadas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categorias = [
      "Frutas",
      "Lacteos",
      "Granos",
      "Congelados",
      "Carnes",
      "Aseo",
      "Personal",
      "Bebés",
      "Pasabocas",
      "Bebidas",
      "Mascotas",
      "Licores",
      "Droguería",
      "Panadería"
    ];

    List<String> imagenes = [
      "assets/image/menu/categorias/1_frutas.png",
      "assets/image/menu/categorias/2_lacteos.png",
      "assets/image/menu/categorias/3_arroz.png",
      "assets/image/menu/categorias/4_congelados.png",
      "assets/image/menu/categorias/5_carnes.png",
      "assets/image/menu/categorias/6_aseo.png",
      "assets/image/menu/categorias/7_cuidado.png",
      "assets/image/menu/categorias/8_bebes.png",
      "assets/image/menu/categorias/9_mecato.png",
      "assets/image/menu/categorias/10_bebidas.png",
      "assets/image/menu/categorias/11_mascotas.png",
      "assets/image/menu/categorias/12_licores.png",
      "assets/image/menu/categorias/13_drogas.png",
      "assets/image/menu/categorias/14_panaderia.png",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categorias.length, (index) {
          return Categoria(
            imagen: imagenes[index],
            titulo: categorias[index],
          );
        }),
      ),
    );
  }
}

class Categoria extends StatelessWidget {
  const Categoria({
    Key? key,
    required this.imagen,
    required this.titulo,
  }) : super(key: key);

  final String imagen, titulo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListaProductos(collectionName: titulo),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 15.0,
          top: 20.0 / 2,
          bottom: 20.0 / 2,
        ),
        width: 80,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage(imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Overpass',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
