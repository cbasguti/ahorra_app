import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_app/vistas/producto/producto.dart';

class OfertasDelDia extends StatelessWidget {
  const OfertasDelDia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nProductos = 0;

    Future<int> getProducts() async {
      final dbProductos = FirebaseDatabase.instance.ref().child('productos');
      dbProductos.once().then((event) {
        nProductos = event.snapshot.children.length;
        print('Hay $nProductos productos.');
      });
      return nProductos;
    }

    getProducts();

    Future<Map<String, dynamic>> getDetails(childN) async {
      final dbRef = FirebaseDatabase.instance.ref().child('productos').child(childN);
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          FutureBuilder<Map<String, dynamic>>(
            future: getDetails('0'),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Ofertas(
                  imagen: NetworkImage(snapshot.data?['image_path']),
                  nombre: snapshot.data?['nombre'] ?? '',
                  tienda: "Exito",
                  precio: snapshot.data?['precio'] ?? 0,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesProducto(),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: getDetails('1'),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Ofertas(
                  imagen: NetworkImage(snapshot.data?['image_path']),
                  nombre: snapshot.data?['nombre'] ?? '',
                  tienda: "Exito",
                  precio: snapshot.data?['precio'] ?? 0,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesProducto(),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: getDetails('2'),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Ofertas(
                  imagen: NetworkImage(snapshot.data?['image_path']),
                  nombre: snapshot.data?['nombre'] ?? '',
                  tienda: "Exito",
                  precio: snapshot.data?['precio'] ?? 0,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesProducto(),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: getDetails('3'),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Ofertas(
                  imagen: NetworkImage(snapshot.data?['image_path']),
                  nombre: snapshot.data?['nombre'] ?? '',
                  tienda: "Exito",
                  precio: snapshot.data?['precio'] ?? 0,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesProducto(),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

class Ofertas extends StatelessWidget {
  const Ofertas({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.tienda,
    required this.precio,
    required this.press,
  }) : super(key: key);

  final NetworkImage imagen;
  final nombre, tienda;
  final int precio;
  final Function press;

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
          Image(image: imagen),
          GestureDetector(
            //onTap: press,
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
              child: Row(
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
                            text: "$tienda".toUpperCase(),
                            style: TextStyle(
                              color: Color(0xFF254587).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$precio',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Color(0xFF254587)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
