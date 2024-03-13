import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';
import '../view/producto/producto_lista.dart';
import '../view/producto/producto_marca.dart';

class ListaMarcas extends StatelessWidget {
  const ListaMarcas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String prueba = "Entra a lista_marca";
    print(prueba);
    List<String> marcas = [
      "Éxito",
      "Euro",
      "Makro",
      "Carulla",
      "Jumbo",
    ];

    List<String> imagenes = [
      "assets/image/menu/marcas/logo_exito.png",
      "assets/image/menu/marcas/logo_euro.png",
      "assets/image/menu/marcas/logo_makro.png",
      "assets/image/menu/marcas/logo_carulla.png",
      "assets/image/menu/marcas/logo_jumbo.png",
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Nuestras Marcas'),
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
          itemCount: marcas.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductosMarca(
                          store: marcas[index], image: imagenes[index]),
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
                        marcas[index],
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
