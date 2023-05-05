import 'package:ahorra_app/vistas/producto/lista_productos.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_app/listado.dart';
import 'package:ahorra_app/listado_detalle.dart';
import 'dart:math';


class ListasDetalles extends StatefulWidget {

  @override
  _ListasDetallesState createState() => _ListasDetallesState();
}


class _ListasDetallesState extends State<ListasDetalles> {

  int _cantidad = 1;

  void _decrementCounter() {
    if (_cantidad > 0) {
      setState(() {
        _cantidad--;
      });
    }
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Lista#'),
       ),
       body: Column(
         children: [
           SizedBox(height: 25.0),
           Container(
             padding: EdgeInsets.all(3.0),
             child: Text(
               'Precio total: ${calcularPrecio()} ',
               textAlign: TextAlign.left,
             ),
             alignment: Alignment.centerLeft,
             margin: EdgeInsets.only(left: 16.0),
           ),
           Container(
             padding: EdgeInsets.all(3.0),
             child: Text(
               'Descuentos: 20000 ',
               textAlign: TextAlign.left,
             ),
             alignment: Alignment.centerLeft,
             margin: EdgeInsets.only(left: 16.0),
           ),
           Container(
             padding: EdgeInsets.only(bottom: 8.0),
             decoration: BoxDecoration(
               border: Border(
                 bottom: BorderSide(width: 2.0, color: Colors.blue.shade600),
               ),
             ),
           ),
           SizedBox(height: 8.0),
           Container(
             padding: EdgeInsets.all(3.0),
             child: Text(
               '${DetalleList.length} productos',
               textAlign: TextAlign.left,
               style: TextStyle(
                 color: Colors.black26,

               ),
             ),
             alignment: Alignment.centerLeft,
             margin: EdgeInsets.only(left: 16.0),
           ),
           Expanded(
             child: ListView.builder(
               itemCount: DetalleList.length,
               itemBuilder: (context, index) {
                 DetalleLista listado2 = DetalleList[index];
                 return Container(
                   constraints: BoxConstraints(maxWidth: 600.0),
                   padding: EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Expanded(
                         child: ListTile(
                           title: Text(listado2.nombre_producto,
                             style: TextStyle(
                               color: Color(0xFF254587),
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           subtitle: Text('Precio unitario: ${listado2.precio}'),
                           leading: Image.network(listado2.imagen),
                         ),
                       ),
                       Expanded(
                         child: Row(

                           children: [
                             Image.network(
                               listado2.tienda,
                               width: 30,
                               height: 30,
                             ),
                             SizedBox(width: 2),
                             IconButton(
                               onPressed: _decrementCounter,
                               icon: SizedBox(
                                 width: 20.0,
                                 height: 20.0,
                                 child: CircleAvatar(
                                   backgroundColor: Colors.grey[600],
                                   child: Icon(
                                     Icons.remove,
                                     color: Colors.white,
                                     size: 16.0, // tamaño del icono dentro del CircleAvatar
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(width: 2),
                             Text(
                               listado2.cantidad.toString(),
                               style: TextStyle(fontSize: 20),
                             ),
                             SizedBox(width: 2),
                             IconButton(
                               onPressed: _decrementCounter,
                               icon: SizedBox(
                                 width: 20.0,
                                 height: 20.0,
                               child: CircleAvatar(
                                 backgroundColor: Color(0xFF254587),
                                 child: Icon(
                                   Icons.add,
                                   color: Colors.white,
                                   size: 16.0,
                                 ),
                               ),
                             ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 );
               },
             ),
           ),
         ],
       ),
     );
   }

   int calcularPrecio(){
     int precio = 0;
     for(int i=0; i<DetalleList.length; i++){
       precio += DetalleList[i].precio * DetalleList[i].cantidad;
     }
     return precio;
   }
}


