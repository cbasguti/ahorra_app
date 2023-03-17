import 'package:flutter/material.dart';
import 'package:ahorra_app/vistas/menu/detalles/detalles_en_pantalla.dart';

class OfertasDelDia extends StatelessWidget {
  const OfertasDelDia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Ofertas(
            imagen: "assets/image/menu/productos/producto1.png",
            nombre: "Hit de Mora",
            tienda: "Exito",
            precio: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesEnPantalla(),
                ),
              );
            },
          ),
          Ofertas(
            imagen: "assets/image/menu/productos/producto2.png",
            nombre: "Golosía",
            tienda: "Carulla",
            precio: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesEnPantalla(),
                ),
              );
            },
          ),
          Ofertas(
            imagen: "assets/image/menu/productos/producto3.png",
            nombre: "Leche entera",
            tienda: "Euro",
            precio: 440,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class Ofertas extends StatelessWidget {
  const Ofertas({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.tienda,
    required this.precio,
    required this.press,
  }) : super(key: key);

  final String imagen, nombre, tienda;
  final int precio;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: 20.0,
        top: 20.0 / 2,
        bottom: 20.0 * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(imagen),
          GestureDetector(
            //onTap: press,
            child: Container(
              padding: EdgeInsets.all(20.0 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xFF254587).withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$nombre\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$tienda".toUpperCase(),
                          style: TextStyle(
                            color: Color(0xFF254587).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$precio',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Color(0xFF254587)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
