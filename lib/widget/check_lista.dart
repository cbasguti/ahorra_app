import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';
import 'check_producto.dart';

class ListaCheck extends StatefulWidget {
  const ListaCheck({Key? key}) : super(key: key);

  @override
  State<ListaCheck> createState() => _ListaCheckState();
}

class _ListaCheckState extends State<ListaCheck> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Nombre de la Lista (CHECKSTEST)'), // TODO: OBTENER EL NOMBRE DE LA LISTA
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: 8, // TODO: NUMERO DE PRODUCTOS QUEMADOS
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: ProductoCheck( // TODO: PARAMETROS QUEMADOS DEL PRODUCTO
                      imagePath: 'assets/image/menu/productos/producto1.png',
                      productName: "HIT DE MORA",
                      price: 3000,
                      quantity: 10,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFF254587),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'TERMINAR',
                    style: TextStyle(
                      fontFamily: 'Overpass',
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}