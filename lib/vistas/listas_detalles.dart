import 'package:flutter/material.dart';
import 'package:ahorra_app/listado_detalle.dart';

class ListasDetalles extends StatefulWidget {
  const ListasDetalles({super.key});

  @override
  ListasDetallesState createState() => ListasDetallesState();
}

class ListasDetallesState extends State<ListasDetalles> {
  int _cantidad = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Mis Listas', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25.0),
          Container(
            padding: const EdgeInsets.all(3.0),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Precio total: ${calcularPrecio()} ',
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3.0),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16.0),
            child: const Text(
              'Descuentos: 20000 ',
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.blue.shade600),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(3.0),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16.0),
            child: Text(
              '${detalleList.length} productos',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black26,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: detalleList.length,
              itemBuilder: (context, index) {
                DetalleLista listado2 = detalleList[index];
                return Container(
                  constraints: const BoxConstraints(maxWidth: 600.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            listado2.nombreProducto,
                            style: const TextStyle(
                              color: Color(0xFF254587),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Precio unitario: ${listado2.precio}'),
                          leading: Image.network(listado2.imagen),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Image.network(
                              listado2.tienda,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: _decrementCounter,
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey[600],
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  '$_cantidad',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                IconButton(
                                  onPressed: _incrementCounter,
                                  icon: const CircleAvatar(
                                    backgroundColor: Color(0xFF254587),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int calcularPrecio() {
    int precio = 0;
    for (int i = 0; i < detalleList.length; i++) {
      precio += detalleList[i].precio * detalleList[i].cantidad;
    }
    return precio;
  }
}
