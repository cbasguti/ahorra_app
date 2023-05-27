import 'package:flutter/material.dart';
import '../helper/utils.dart';
import 'check_producto.dart';
import 'package:ahorra_app/helper/utils.dart';
import 'package:ahorra_app/model/listado_detalle.dart';
import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/database_service.dart';

class ListaCheck extends StatefulWidget {
  const ListaCheck({
    Key? key,
    required this.lista,
    required this.precioTotal,
  }) : super(key: key);

  final String lista, precioTotal;

  @override
  State<ListaCheck> createState() => _ListaCheckState();
}

class _ListaCheckState extends State<ListaCheck> {
  int _precioAcumulado = 0;
  final dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _updateTotal();
  }

  Future<void> _updateTotal() async {
    final precioNuevo = await dbService.currentTotal(widget.lista);
    setState(() {
      _precioAcumulado = precioNuevo;
    });
  }

  final myStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontFamily: 'Overpass',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.lista),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_box_outline_blank,
                    color: Color(0xFF254587),
                  ))
            ]
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Precio total:', style: myStyle),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('${widget.precioTotal}', style: myStyle),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Precio acumulado:', style: myStyle),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child:
                          Text(formatPrice(_precioAcumulado), style: myStyle),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: FutureBuilder<List<Producto>>(
                      future: dbService.getProducts(widget.lista),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Producto>> snapshot) {
                        if (snapshot.hasData) {
                          final productos = snapshot.data!;
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String? tienda =
                                  snapshot.data![index].tiendaSeleccionada;
                              String precio = formatPrice(snapshot.data![index]
                                  .getPriceForStore(tienda!));
                              String nombre = snapshot.data![index].nombre;
                              int productoId = snapshot.data![index].id;
                              String categoria =
                                  snapshot.data![index].categoria;
                              String imgUrl = snapshot.data![index].imagen;
                              int? cantidad = snapshot.data![index].cantidad;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: ProductoCheck(
                                  lista: widget.lista,
                                  imagen: imgUrl,
                                  nombre: nombre,
                                  precio: precio,
                                  cantidad: cantidad,
                                  categoria: categoria,
                                  productoId: productoId,
                                  tienda: tienda,
                                  updateTotal: _updateTotal,
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
