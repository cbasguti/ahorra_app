import 'package:ahorra_app/vistas/producto/producto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../home/home.dart';

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

  final List<String> _tiendas = List.generate(4, (index) => "assets/image/menu/marcas/logo_d1.png");
  int _nProductos = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    final dbProductos = FirebaseDatabase.instance.ref().child('productos').child(widget.collectionName);
    dbProductos.once().then((event) {
      setState(() {
        _nProductos = event.snapshot.children.length;
      });
    });
  }

  Future<Map<String, dynamic>> getDetails(childN) async {
    final dbRef = FirebaseDatabase.instance.ref().child('productos').child(widget.collectionName).child(childN);
    final snapshot = await dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    final detalles = <String, dynamic>{};
    values.forEach((key, value) {
      if (key == 'nombre') {
        detalles['nombre'] = value;
      } else if (key == 'image_path') {
        detalles['image_path'] = value;
      } else if (key == 'precios') {
        detalles['precio'] = value['euro'];
      }
    });
    return detalles;
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
          title: const Text("Todos los productos"),
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
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xFF254587).withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Busca aquí tus productos",
                        hintStyle: TextStyle(
                          color: Color(0xFF254587).withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(13.0),
                itemCount: _nProductos,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.66,
                ),
                itemBuilder: (context, index) {
                  return FutureBuilder<Map<String, dynamic>>(
                    future: getDetails(index.toString()), // Pasa el índice como parámetro
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return Productos(
                          imagen: snapshot.data?['image_path'] ?? '',
                          nombre: snapshot.data?['nombre'] ?? '',
                          tienda: "Exito",
                          precio: snapshot.data?['precio'] ?? 0,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
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

class Productos extends StatelessWidget {
  const Productos({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.tienda,
    required this.precio,
  }) : super(key: key);

  final imagen, nombre, tienda;
  final int precio;

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
                    imagen: imagen,
                    tienda: tienda,
                    nombre: nombre,
                    precio: precio,
                  ),
                ),
              );
            },
            child: Image(image: NetworkImage(imagen)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesProducto(
                    imagen: imagen,
                    tienda: tienda,
                    nombre: nombre,
                    precio: precio,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(20.0 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xFF254587).withOpacity(0.23),
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
                        translation: Offset(0.0, 0.3),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/image/menu/marcas/logo_exito.png', // TODO: CAMBIAR ESTO PARA QUE LA IMAGEN NO SEA ESTATICA
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
                                text: "$nombre\n".toUpperCase(),
                                style: Theme.of(context).textTheme.button,
                              ),
                              TextSpan(
                                text: '\$$precio',
                                style: Theme.of(context).textTheme.button?.copyWith(
                                  color: Color(0xFF254587),
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
