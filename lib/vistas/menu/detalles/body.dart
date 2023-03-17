import 'package:flutter/material.dart';

import 'imagen_e_icono.dart';
import 'titulo_y_precio.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImagenEIcono(size: size),
          const TituloYPrecio(nombre: "Hit de Mora", tienda: "Russia", precio: 440),
          const SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                      // backgroundColor: Color(0xFF254587),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text("Descripción"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
