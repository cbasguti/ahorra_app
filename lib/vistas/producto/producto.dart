import 'dart:math';

import 'package:ahorra_app/vistas/home/home.dart';
import 'package:flutter/material.dart';

import '../Sidebar/sidebar.dart';

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

  void _incrementCounter() {
    setState(() {
      _cantidad++;
    });
  }

  void _decrementCounter() {
    if (_cantidad > 0) {
      setState(() {
        _cantidad--;
      });
    }
  }

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.nombre),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Stack(
                      children: [
                        MenuLateral(),
                        MenuPrincipal(),
                      ],
                    ),
                  ),
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
                    width: 250,
                    height: 250,
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\$${widget.precio}',
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${widget.tienda}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: _decrementCounter,
                                                icon: CircleAvatar(
                                                  backgroundColor: Colors.grey[600],
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$_cantidad',
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              IconButton(
                                                onPressed: _incrementCounter,
                                                icon: CircleAvatar(
                                                  backgroundColor: Color(0xFF254587),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.add_box_outlined,
                                                  color: Color(0xFF254587),
                                                ),
                                              ),
                                              Text(
                                                'Añadir a una lista',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF254587),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "Precios",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (int index = 0; index < min(5, _tiendas.length); index++)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                                border: _selectedIndex == index
                                                    ? Border.all(
                                                  color: Colors.yellow,
                                                  width: 2,
                                                )
                                                    : null,
                                              ),
                                              child: Stack(
                                                children: [
                                                  Opacity(
                                                    opacity: 0.4,
                                                    child: ClipRect(
                                                      clipBehavior: Clip.antiAlias,
                                                      child: FractionalTranslation(
                                                        translation: Offset(0.0, 0.3),
                                                        child: Align(
                                                          alignment: Alignment.bottomRight,
                                                          child: Image.asset(
                                                            'assets/image/menu/marcas/logo_exito.png',
                                                            width: 60,
                                                            height: 60,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text(
                                                        '\$${widget.precio}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color(0xFF254587),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                  Text(
                                    "Detalles del Productos",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}