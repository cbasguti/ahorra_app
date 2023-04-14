import 'dart:math';

import 'package:ahorra_app/vistas/home/home.dart';
import 'package:flutter/material.dart';

class DetallesProducto extends StatefulWidget {
  const DetallesProducto({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.tienda,
    required this.precio,
}) : super(key: key);

  final imagen, nombre, tienda;
  final int precio;

  @override
  State<DetallesProducto> createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  int _cantidad = 0;
  final List<String> _tiendas = List.generate(4, (index) => "assets/image/menu/marcas/logo_d1.png");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Detalles del Producto"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuPrincipal(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xFF254587),
                )
            )
          ]
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: ListView(
                children: [
                  Image.network(
                    widget.imagen, //Acá poner el path de la imagen del producto
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )
                      ),
                      child: Padding(
                       padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.nombre, // Acá poner el nombre del producto
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF254587),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '\$${widget.precio}', // Acá poner el precio del producto
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                              //Acá poner la descripción del producto
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row( // Row con las tiendas que cambien el precio del producto, todavia hay que cambiar cosas
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int index = 0;
                                  index < min(5, _tiendas.length);
                                  index++)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                      Image.asset(_tiendas[index], width: 55),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )
          ),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        if (_cantidad > 0) {
                          _cantidad--;
                        }
                      }),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey.shade900,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Text(
                      "$_cantidad",
                      style: const TextStyle(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _cantidad++;
                      }),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey.shade900,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey.shade900,
                    ),
                    fixedSize: MaterialStateProperty.all(
                      const Size(double.infinity, 65),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Añadir a la lista",
                    style: TextStyle(fontSize: 20),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}