import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/view/home/home.dart';
import 'package:ahorra_app/view/producto/producto_detalle.dart';
import 'package:ahorra_app/widget/sidebar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListaProductos extends StatefulWidget {
  final String collectionName;

  const ListaProductos({
    Key? key,
    required this.collectionName,
  }) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  int _nProductos = 0;
  String _busqueda = '';
  final List<Producto> _productosLista = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void _actualizarBusqueda(String busqueda) {
    setState(() {
      _busqueda = busqueda;
      getProductsBySearch(busqueda);
    });
  }

  Future<void> getProductsBySearch(String busqueda) async {
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('productos')
        .child(widget.collectionName);
    final snapshot = await dbRef.get();
    bool cumple = false;
    int count = 0;
    List<Map<dynamic, dynamic>> productos = [];
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (key == 'nombre') {
          if (RegExp(_busqueda, caseSensitive: false).hasMatch(value)) {
            cumple = true;
            count++;
          }
        }
      });
      if (cumple) {
        productos.add(values);
      }
      cumple = false;
    }
    setState(() {
      _nProductos = count;
    });
  }

  Future<void> getProducts() async {
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('productos')
        .child(widget.collectionName);
    final snapshot = await dbRef.get();
    int count = 0;
    List<Map<dynamic, dynamic>> productos = [];
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      productos.add(values);
      Producto producto = Producto(
        id: count,
        nombre: values['nombre'],
        imagen: values['image_path'],
        categoria: widget.collectionName,
        precios: values['precios'],
      );
      _productosLista.add(producto);
      count++;
    }
    setState(() {
      _nProductos = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.collectionName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Stack(
                      children: const [
                        MenuLateral(),
                        MenuPrincipal(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: const Color(0xFF254587).withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: _actualizarBusqueda,
                      decoration: InputDecoration(
                        hintText: "Busca aquí tus productos",
                        hintStyle: TextStyle(
                          color: const Color(0xFF254587).withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.search),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(13.0),
                itemCount: _nProductos,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.66,
                ),
                itemBuilder: (context, index) {
                  final producto = _productosLista[index];
                  return ProductosCard(
                    producto: producto,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductosCard extends StatelessWidget {
  const ProductosCard({
    Key? key,
    required this.producto,
  }) : super(key: key);

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: 20.0,
        top: 20.0 / 2,
        bottom: 20.0 * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesProducto(
                    producto: producto,
                  ),
                ),
              );
            },
            child: Image(image: NetworkImage(producto.imagen)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesProducto(
                    producto: producto,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20.0 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: const Color(0xFF254587).withOpacity(0.23),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipRect(
                      clipBehavior: Clip.antiAlias,
                      child: FractionalTranslation(
                        translation: const Offset(0.0, 0.3),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/image/menu/marcas/logo_${producto.getLowestPriceStore()}.png', // Que no sea estatica
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${producto.nombre}\n".toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextSpan(
                                text: '\$${producto.getLowestPrice()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: const Color(0xFF254587),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
