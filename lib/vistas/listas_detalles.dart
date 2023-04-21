import 'package:flutter/material.dart';
import 'package:ahorra_app/listado.dart';


class ListasDetalles extends StatelessWidget {
   final Listado listado;

   ListasDetalles(this.listado);

   @override
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         title: Text(listado.nombre),
       ),
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.network(listado.imagen),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                   'Aca va todo el detalle de su lista'
               ),

             )
           ],
         ),
       ),
     );
   }


}


