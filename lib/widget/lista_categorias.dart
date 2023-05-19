import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';
import '../view/producto/producto_lista.dart';

class ListaCategorias extends StatelessWidget {
  const ListaCategorias({Key? key}) : super(key: key);

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

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Categorias'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: categorias.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaProductos(collectionName: categorias[index]),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(imagenes[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        categorias[index],
                        style: const TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          height: 1.33,
                          letterSpacing: -0.24,
                          color: Color.fromRGBO(9, 28, 63, 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
