import 'package:flutter/material.dart';

class TituloYPrecio extends StatelessWidget {
  const TituloYPrecio({
    Key? key,
    required this.nombre,
    required this.tienda,
    required this.precio,
  }) : super(key: key);

  final String nombre, tienda;
  final int precio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$nombre\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Color(0xFF090F47), fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: tienda,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF254587),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "\$$precio",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Color(0xFF254587)),
          )
        ],
      ),
    );
  }
}
