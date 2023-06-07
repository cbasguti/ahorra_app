import 'package:ahorra_app/helper/utils.dart';
import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/widget/listas_popup.dart';
import 'package:flutter/material.dart';

class DetallesProducto extends StatefulWidget {
  const DetallesProducto({
    Key? key,
    required this.producto,
  }) : super(key: key);

  final Producto producto;

  @override
  State<DetallesProducto> createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  int _cantidad = 1;
  int _selectedPrice = 0;
  int _nTiendas = 0;
  String _selectedStore = '';

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.producto.getLowestPrice();
    _selectedStore = widget.producto.getLowestPriceStore();
    _nTiendas = widget.producto.precios.length;
  }

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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.producto.organizePricesAscending();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(widget.producto.nombre),
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
                    Icons.favorite,
                    color: Color(0xFF254587),
                  ))
            ]),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: ListView(
                children: [
                  Image.network(
                    widget.producto
                        .imagen, //Acá poner el path de la imagen del producto
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${formatPrice(_selectedPrice)}',
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                _selectedStore,
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
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed:
                                                        _decrementCounter,
                                                    icon: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[600],
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '$_cantidad',
                                                    style: const TextStyle(
                                                        fontSize: 24),
                                                  ),
                                                  IconButton(
                                                    onPressed:
                                                        _incrementCounter,
                                                    icon: const CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xFF254587),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.add_box_outlined,
                                                    color: Color(0xFF254587),
                                                  ),
                                                ),
                                                ListasPopUp(
                                                  producto: widget.producto,
                                                  cantidad: _cantidad,
                                                  selectedStore: _selectedStore,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            for (int index = 0;
                                                index < _nTiendas;
                                                index++)
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedIndex = index;
                                                        _selectedPrice = widget
                                                            .producto
                                                            .getPriceByIndex(
                                                                index);
                                                        _selectedStore = widget
                                                            .producto
                                                            .getStoreByIndex(
                                                                index);
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: Container(
                                                        width: 100,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ],
                                                          border:
                                                              _selectedIndex ==
                                                                      index
                                                                  ? Border.all(
                                                                      color: Colors
                                                                          .yellow,
                                                                      width: 2,
                                                                    )
                                                                  : null,
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Opacity(
                                                              opacity: 0.4,
                                                              child: ClipRect(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                child:
                                                                    FractionalTranslation(
                                                                  translation:
                                                                      const Offset(
                                                                          0.0,
                                                                          0.3),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/image/menu/marcas/logo_${widget.producto.getStoreByIndex(index)}.png',
                                                                      width: 60,
                                                                      height:
                                                                          60,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  '${formatPrice(widget.producto.getPriceByIndex(index))}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20,
                                                                    color: Color(
                                                                        0xFF254587),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        "Detalles del Productos",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.producto.descripcion ?? "",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
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
