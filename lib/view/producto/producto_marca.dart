import 'package:ahorra_app/helper/utils.dart';
import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/database_service.dart';
import 'package:ahorra_app/view/producto/producto_detalle.dart';
import 'package:flutter/material.dart';

class ProductosMarca extends StatefulWidget {
  final String store;
  final String image;

  const ProductosMarca({
    Key? key,
    required this.store,
    required this.image,
  }) : super(key: key);

  @override
  State<ProductosMarca> createState() => _ProductosMarcaState();
}

class _ProductosMarcaState extends State<ProductosMarca> {
  int _nProductos = 0;
  List<Producto> _productosLista = [];
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    initList();
  }

  void _actualizarBusqueda(String busqueda) async {
    int productsCount = 0;
    List<Producto> productos = [];
    String storeNormalized = quitarAcentosYMinusculas(widget.store);
    productos = await _databaseService.searchByStore(busqueda, storeNormalized);
    if (mounted) {
      setState(() {
        _nProductos = productos.length;
        _productosLista = productos;
      });
    }
  }

  String quitarAcentosYMinusculas(String texto) {
    String textoSinAcentos = texto
        .replaceAll(RegExp(r'[áÁ]'), 'a')
        .replaceAll(RegExp(r'[éÉ]'), 'e')
        .replaceAll(RegExp(r'[íÍ]'), 'i')
        .replaceAll(RegExp(r'[óÓ]'), 'o')
        .replaceAll(RegExp(r'[úÚüÜ]'), 'u');
    String textoNormalizado = textoSinAcentos.toLowerCase();
    return textoNormalizado;
  }

  Future<void> initList() async {
    int productsCount = 0;
    List<Producto> productos = [];
    String storeNormalized = quitarAcentosYMinusculas(widget.store);
    productos = await _databaseService.getProductsByStore(storeNormalized);
    if (mounted) {
      setState(() {
        _nProductos = productos.length;
        _productosLista = productos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String prueba = "Entra a producto_marca";
    String storeNormalized = quitarAcentosYMinusculas(widget.store);
    print(storeNormalized);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.store),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            BannerDeMarca(
              store: widget.store,
              imagen: widget.image,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
                    store: storeNormalized,
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
    required this.store,
    required this.producto,
  }) : super(key: key);

  final Producto producto;
  final String store;

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
                            'assets/image/menu/marcas/logo_${store}.png', // Que no sea estatica
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
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
                                text:
                                    '${formatPrice(producto.getPriceForStore(store))}',
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

class BannerDeMarca extends StatelessWidget {
  const BannerDeMarca({
    Key? key,
    required this.imagen,
    required this.store,
  }) : super(key: key);
  final String imagen;
  final String store;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (store == 'Éxito') {
      backgroundColor = Color(0xFFFFE404);
    } else if (store == 'Euro') {
      backgroundColor = Color(0xFF08148C);
    } else if (store == 'Makro') {
      backgroundColor = Color(0xFFE8141C);
    } else if (store == 'Carulla') {
      backgroundColor = Color(0xFF90BC04);
    } else if (store == 'Jumbo') {
      backgroundColor = Color(0xFF108C24);
    } else {
      backgroundColor = Colors.white; // Color predeterminado
    }
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 150,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 50,
            color: const Color(0xFF254587).withOpacity(0.23),
          ),
        ],
      ),
      child: Image.asset(
        imagen,
      ),
    );
  }
}
