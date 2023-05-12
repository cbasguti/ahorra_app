import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';

class InformacionScreen extends StatefulWidget {
  const InformacionScreen({Key? key}) : super(key: key);

  @override
  State<InformacionScreen> createState() => _InformacionScreenState();
}

class _InformacionScreenState extends State<InformacionScreen> {

  final TextStyle myTextStyle = TextStyle(
    fontFamily: 'Overpass',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    height: 1.33,
    letterSpacing: -0.24,
    color: Color.fromRGBO(9, 28, 63, 0.75),
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
          title: Text('Información'),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset('assets/image/splash/logodark.png', height: 200),
              SizedBox(height: 10),
              const Text(
                'Es una aplicación móvil que facilita la tarea de hacer compras en cualquier supermercado o tienda, permitiendo a los usuarios personalizar sus listas de compras, comparar precios de diferentes supermercados o tiendas y recibir sugerencias de productos relevantes.',
                style: TextStyle(
                  fontFamily: 'Overpass',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  height: 1.33,
                  letterSpacing: -0.24,
                  color: Color.fromRGBO(9, 28, 63, 0.75),
                ),
              ),
              SizedBox(height: 50),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/image/logo_udea.png', width: 70), // Reemplazar con la imagen correspondiente
                      SizedBox(width: 16),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text('Sara Uribe Zapata', style: myTextStyle),
                            Text('Diego Jose Luis Botia', style: myTextStyle),
                            Text('Juan Esteban Salas Flórez', style: myTextStyle),
                            Text('Sebastian Gutierrez Jaramillo', style: myTextStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
