import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/widget/sidebar.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';

class CheckLista extends StatefulWidget {
  const CheckLista({Key? key}) : super(key: key);

  @override
  State<CheckLista> createState() => _CheckListaState();
}

class _CheckListaState extends State<CheckLista> {
  final TextStyle myTextStyle = const TextStyle(
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
          title: const Text('Nombre de la lista (CHECKS)'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ProductoCheck(
              isChecked: true,
              imagePath: 'assets/image/menu/productos/producto1.png',
              productName: 'HIT DE MORA',
              price: 3000,
              quantity: 5,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductoCheck extends StatelessWidget {
  final bool isChecked;
  final String imagePath;
  final String productName;
  final double price;
  final int quantity;

  ProductoCheck({
    required this.isChecked,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {},
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? Colors.green.withOpacity(0.5) : Colors.transparent,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: TextStyle(
                  fontFamily: 'Overpass',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  height: 1.33,
                  letterSpacing: -0.24,
                  color: Color.fromRGBO(9, 28, 63, 0.75),
                  fontWeight: FontWeight.bold,
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Text(
                '\$$price',
                style: TextStyle(
                  fontFamily: 'Overpass',
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/image/menu/marcas/logo_lapeña.png'),
            ),
            SizedBox(width: 50),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
