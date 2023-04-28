import 'package:flutter/material.dart';


class DetalleLista{
  String nombre_producto;
  int precio;
  String imagen;
  int cantidad;
  String tienda;

  DetalleLista(
      {
        required this.nombre_producto,
        required this.precio,
        required this.imagen,
        required this.cantidad,
        required this.tienda
      });
}


  List<DetalleLista> DetalleList = [
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/djyt3kv/sugar.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/rQYVVM4/exito.png'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/SckFP2S/oralb.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/v3yn3kF/euro.jpg'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/djyt3kv/sugar.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/rQYVVM4/exito.png'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/Fm09qL2/mediarojo.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/v3yn3kF/euro.jpg'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/HxDjJBS/oreo.jpg',
        cantidad: 2,
        tienda: 'https://i.ibb.co/rQYVVM4/exito.png'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/djyt3kv/sugar.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/v3yn3kF/euro.jpg'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/HxDjJBS/oreo.jpg',
        cantidad: 2,
        tienda: 'https://i.ibb.co/rQYVVM4/exito.png'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/djyt3kv/sugar.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/v3yn3kF/euro.jpg'
    ),
    DetalleLista(
        nombre_producto: 'Sugar free gold',
        precio: 5600,
        imagen: 'https://i.ibb.co/Fm09qL2/mediarojo.webp',
        cantidad: 2,
        tienda: 'https://i.ibb.co/rQYVVM4/exito.png'
    ),
  ];

  double calcularPrecioTotal() {
    double precioTotal = 0.0;
    for (int i = 0; i < DetalleList.length; i++) {
      precioTotal += DetalleList[i].precio * DetalleList[i].cantidad;
    }
    return precioTotal;
  }

