import 'package:flutter/material.dart';

class ProductoCheck extends StatefulWidget {
  const ProductoCheck({
    Key? key,
    required this.imagen,
    required this.nombre,
    required this.precio,
    required this.cantidad,
  }) : super(key: key);

  final String imagen, nombre, precio;
  final int? cantidad;

  @override
  State<ProductoCheck> createState() => _ProductoCheckState();
}

class _ProductoCheckState extends State<ProductoCheck> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  widget.imagen,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nombre,
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 18,
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
                      widget.precio,
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 16,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/image/menu/marcas/logo_exito.png', // TODO: OBTENER LA TIENDA EL PRODUCTO AGREGADO
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[500],
                    ),
                    child: Center(
                      child: Text(
                        widget.cantidad.toString(),
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
          ),
        ),
        if (isChecked)
          IgnorePointer(
            ignoring: true,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.green.withOpacity(0.5), BlendMode.srcATop),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.withOpacity(0.2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
