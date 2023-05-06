import 'dart:async';

import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/auth/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final _dbRef = FirebaseDatabase.instance.ref().child('usuarios');
  final _productosRef = FirebaseDatabase.instance.ref().child('productos');
  final _auth = AuthService();
  late final String _userKey;

  DatabaseService() {
    _getUserKey();
  }

  Future<void> _getUserKey() async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        _userKey = key;
      }
    });
  }

  Future<void> printEmails() async {
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      if (kDebugMode) {
        print(value['correo']);
      }
    });
  }

  Future<void> crearNuevaLista(String titulo) async {
    final newDbRef = _dbRef.child('$_userKey/listas');
    newDbRef.push().set({'titulo': titulo});
  }

  Future<void> addProductoToLista(
      String lista, Producto producto, int cantidad) async {
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      if (value['titulo'] == lista) {
        final productDbRef = listaDbRef.child(key).child('productos');
        productDbRef.push().set({
          'categoria': producto.categoria,
          'id': producto.id,
          'cantidad': cantidad,
        });
      }
    });
  }

  Future<int> getListCount() async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    int count = 0;
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            count++;
          });
        }
      }
    });
    if (kDebugMode) {
      print('DatabaseService.getLists: $count');
    }
    return count;
  }

  Future<List> getLists() async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    List lists = [];
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            lists.add(value['titulo']);
          });
        }
      }
    });
    return lists;
  }

  Future<String> getUsername() async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    String userId = '';
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        userId = value['nombre'];
      }
    });
    return userId;
  }

  /* Future<int> getProducts() async {
    final dbProductos =
        FirebaseDatabase.instance.ref().child('productos').child('Ofertas');
    dbProductos.once().then((event) {
      nProductos = event.snapshot.children.length;
    });
    return nProductos;
  } */

  Future<List<Producto>> getDetails() async {
    final dbRef = _productosRef.child('Ofertas');
    final snapshot = await dbRef.get();
    int count = 0;
    List<Producto> productosLista = [];
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      Producto producto = Producto(
        id: count,
        nombre: values['nombre'],
        imagen: values['image_path'],
        categoria: 'Ofertas',
        precios: values['precios'],
      );
      productosLista.add(producto);
    }
    return productosLista;
  }
}
