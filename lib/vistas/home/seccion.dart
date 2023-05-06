import 'package:flutter/material.dart';

class TituloYBoton extends StatelessWidget {
  const TituloYBoton({
    Key? key,
    required this.titulo,
    required this.press,
  }) : super(key: key);
  final String titulo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          TituloConInterlineado(texto: titulo),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: const Color(0xFF254587),
            ),
            onPressed: () {},
            child: const Text(
              "Más",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TituloConInterlineado extends StatelessWidget {
  const TituloConInterlineado({
    Key? key,
    required this.texto,
  }) : super(key: key);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0 / 4),
            child: Text(
              texto,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 20.0 / 4),
              height: 7,
              color: const Color(0xFF254587).withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
