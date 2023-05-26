import 'package:ahorra_app/helper/utils.dart';
import 'package:ahorra_app/model/listado_detalle.dart';
import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:flutter/material.dart';

import '../../widget/lista_categorias.dart';

class ListasDetalles extends StatefulWidget {
  const ListasDetalles({
    Key? key,
    required this.lista,
    required this.precioTotal,
  }) : super(key: key);

  final String lista, precioTotal;

  @override
  ListasDetallesState createState() => ListasDetallesState();
}

class ListasDetallesState extends State<ListasDetalles> {
  int _precioTotal = 0;
  final _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _precioTotal =
        int.parse(widget.precioTotal.replaceAll(r'$', '').replaceAll('.', ''));
  }

  Future<void> _incrementCounter(String lista, Producto producto) async {
    await _dbService.addProductoToLista(lista, producto, 1);
    await _dbService.getProductCount(widget.lista);
    setState(() {
      _precioTotal += producto.getPriceForStore(producto.tiendaSeleccionada!);
    });
  }

  Future<void> _decrementCounter(String lista, Producto producto) async {
    await _dbService.removeProductoFromLista(lista, producto, 1);
    await _dbService.getProductCount(widget.lista);
    setState(() {
      _precioTotal -= producto.getPriceForStore(producto.tiendaSeleccionada!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.lista, style: TextStyle(color: Colors.black)),
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
              'Precio total: ${formatPrice(_precioTotal)}',
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
          FutureBuilder<int>(
            future: dbService.getProductCount(widget.lista),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        '${snapshot.data} productos',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF254587),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListaCategorias(),
                              ),
                            );
                          },
                          child: Text(
                            'Añadir más',
                            style: TextStyle(
                              color: Color(0xFF254587),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<Producto>>(
              future: dbService.getProducts(widget.lista),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Producto>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        DetalleLista listado2 = detalleList[index];
                        String? tienda =
                            snapshot.data![index].tiendaSeleccionada;
                        String precio = formatPrice(
                            snapshot.data![index].getPriceForStore(tienda!));
                        String nombre = snapshot.data![index].nombre;
                        String imgUrl = snapshot.data![index].imagen;
                        int? cantidad = snapshot.data![index].cantidad;
                        Producto producto = snapshot.data![index];
                        return Container(
                          constraints: const BoxConstraints(maxWidth: 600.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    nombre,
                                    style: const TextStyle(
                                      color: Color(0xFF254587),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('Precio unitario: $precio'),
                                  leading: Image.network(imgUrl),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/image/menu/marcas/logo_$tienda.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    const SizedBox(width: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _decrementCounter(
                                                widget.lista, producto);
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor: Colors.grey[600],
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$cantidad',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _incrementCounter(
                                                widget.lista, producto);
                                          },
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
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
