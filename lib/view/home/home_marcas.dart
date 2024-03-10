import 'package:ahorra_app/view/producto/producto_marca.dart';
import 'package:flutter/material.dart';

class NuestrasMarcas extends StatelessWidget {
  const NuestrasMarcas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CartaDeMarca(
            imagen: "assets/image/menu/marcas/logo_exito.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductosMarca(
                      store: 'Éxito',
                      image: "assets/image/menu/marcas/logo_exito.png"),
                ),
              );
            },
          ),
          CartaDeMarca(
            imagen: "assets/image/menu/marcas/logo_euro.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductosMarca(
                      store: 'Euro',
                      image: "assets/image/menu/marcas/logo_euro.png"),
                ),
              );
            },
          ),
          CartaDeMarca(
            imagen: "assets/image/menu/marcas/logo_makro.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductosMarca(
                      store: 'Makro',
                      image: "assets/image/menu/marcas/logo_makro.png"),
                ),
              );
            },
          ),
          CartaDeMarca(
            imagen: "assets/image/menu/marcas/logo_carulla.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductosMarca(
                      store: 'Carulla',
                      image: "assets/image/menu/marcas/logo_carulla.png"),
                ),
              );
            },
          ),
          CartaDeMarca(
            imagen: "assets/image/menu/marcas/logo_jumbo.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductosMarca(
                      store: 'Jumbo',
                      image: "assets/image/menu/marcas/logo_jumbo.png"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CartaDeMarca extends StatelessWidget {
  const CartaDeMarca({
    Key? key,
    required this.imagen,
    required this.press,
  }) : super(key: key);
  final String imagen;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          top: 20.0 / 2,
          bottom: 20.0 / 2,
        ),
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            //fit: BoxFit.cover,
            image: AssetImage(imagen),
          ),
        ),
      ),
    );
  }
}
