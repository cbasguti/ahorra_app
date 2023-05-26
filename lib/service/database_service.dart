import 'dart:async';

import 'package:ahorra_app/helper/utils.dart';
import 'package:ahorra_app/model/listado.dart';
import 'package:ahorra_app/model/producto.dart';
import 'package:ahorra_app/service/auth/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final _dbRef = FirebaseDatabase.instance.ref().child('usuarios');
  final _productosRef = FirebaseDatabase.instance.ref().child('productos');
  final _feedbackRef = FirebaseDatabase.instance.ref().child('feedback');
  final _auth = AuthService();
  String _userKey = '-NUfJz0guxDHYdm-ei8v';

  DatabaseService() {
    _getUserKey();
  }

  // Getter para obtener el userKey
  String get userKey => _userKey;

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
    late final DatabaseReference productDbRef;

    bool productoExiste = false;

    values.forEach((key, value) async {
      if (value['titulo'] == lista) {
        productDbRef = listaDbRef.child(key).child('productos');

        final snapshot2 = await productDbRef.get();
        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;
          values2.forEach((key, value) {
            if (value['categoria_id'] ==
                '${producto.categoria}_${producto.id}') {
              final int cantidadActual = value['cantidad'] as int;
              final int cantidadNueva = cantidadActual + cantidad;
              productDbRef.child(key).update({'cantidad': cantidadNueva});
              productoExiste = true;
            }
          });
        }

        if (!productoExiste) {
          productDbRef.push().set({
            'categoria_id': '${producto.categoria}_${producto.id}',
            'cantidad': cantidad,
            'checked': false,
          });
        }
      }
    });
  }

  Future<void> addProductoWithStore(
      String lista, Producto producto, int cantidad, String tienda) async {
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    late final DatabaseReference productDbRef;

    bool productoExiste = false;

    values.forEach((key, value) async {
      if (value['titulo'] == lista) {
        productDbRef = listaDbRef.child(key).child('productos');

        final snapshot2 = await productDbRef.get();
        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;
          values2.forEach((key, value) {
            if (value['categoria_id'] ==
                '${producto.categoria}_${producto.id}') {
              final int cantidadActual = value['cantidad'] as int;
              final int cantidadNueva = cantidadActual + cantidad;
              productDbRef.child(key).update({'cantidad': cantidadNueva});
              productoExiste = true;
            }
          });
        }

        if (!productoExiste) {
          productDbRef.push().set({
            'categoria_id': '${producto.categoria}_${producto.id}',
            'cantidad': cantidad,
            'checked': false,
            'tienda': tienda,
          });
        }
      }
    });
  }

  Future<String> getTiendaFromProducto(String lista, String categoriaId) async {
    await _getUserKey();
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    late final DatabaseReference productDbRef;
    String selectedStore = '';

    await Future.forEach(values.entries, (entry) async {
      final key = entry.key;
      final value = entry.value;

      if (value['titulo'] == lista) {
        productDbRef = listaDbRef.child(key).child('productos');
        final snapshot2 = await productDbRef.get();

        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;

          values2.forEach((key, value) {
            if (value['categoria_id'] == categoriaId) {
              selectedStore = value['tienda'] ?? false;
            }
          });
        }
      }
    });

    return selectedStore;
  }

  Future<void> checkProduct(
      String lista, String categoria, int id, bool checked) async {
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    late final DatabaseReference productDbRef;

    values.forEach((key, value) async {
      if (value['titulo'] == lista) {
        productDbRef = listaDbRef.child(key).child('productos');

        final snapshot2 = await productDbRef.get();
        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;
          values2.forEach((key, value) {
            if (value['categoria_id'] == '${categoria}_$id') {
              productDbRef.child(key).update({'checked': checked});
            }
          });
        }
      }
    });
  }

  Future<bool> isChecked(String lista, String categoria, int id) async {
    await _getUserKey();
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    late final DatabaseReference productDbRef;
    bool isChecked = false;

    await Future.forEach(values.entries, (entry) async {
      final key = entry.key;
      final value = entry.value;

      if (value['titulo'] == lista) {
        productDbRef = listaDbRef.child(key).child('productos');
        final snapshot2 = await productDbRef.get();

        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;

          values2.forEach((key, value) {
            if (value['categoria_id'] == '${categoria}_$id') {
              isChecked = value['checked'] ?? false;
            }
          });
        }
      }
    });

    return isChecked;
  }

  Future<int> currentTotal(String lista) async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    int totalPrice = 0;
    List productosLista = [];
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            if (value['titulo'] == lista) {
              if (value['productos'] != null) {
                final productos = value['productos'] as Map<dynamic, dynamic>;
                productos.forEach((key, value) {
                  final categoriaId = value['categoria_id'];
                  final cantidad = value['cantidad'].toString();
                  final tienda = value['tienda'];

                  final productoData = {
                    'categoria_id': categoriaId,
                    'cantidad': cantidad,
                    'tienda': tienda,
                  };

                  if (value['checked'] == true) {
                    productosLista.add(productoData);
                  }
                });
              }
            }
          });
        }
      }
    });

    for (var element in productosLista) {
      final String categoria = element['categoria_id'].split('_')[0];
      final String id = element['categoria_id'].split('_')[1];
      final String cantidad = element['cantidad'];
      final tienda = element['tienda'];

      final productoRef = _productosRef.child(categoria).child(id);
      final snapshot = await productoRef.get();
      final values = snapshot.value as Map<dynamic, dynamic>;
      Producto producto = Producto(
          id: int.parse(id),
          nombre: values['nombre'],
          categoria: categoria,
          precios: values['precios'],
          imagen: values['image_path'],
          cantidad: int.parse(cantidad),
          tiendaSeleccionada: tienda);
      totalPrice += (producto.getPriceForStore(tienda) * int.parse(cantidad));
    }
    return totalPrice;
  }

  Future<void> removeProductoFromLista(
      String lista, Producto producto, int cantidad) async {
    final listaDbRef = _dbRef.child(_userKey).child('listas');
    final snapshot = await listaDbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    values.forEach((key, value) async {
      if (value['titulo'] == lista) {
        final productDbRef = listaDbRef.child(key).child('productos');
        final snapshot2 = await productDbRef.get();

        if (snapshot2.value != null) {
          final values2 = snapshot2.value as Map<dynamic, dynamic>;

          values2.forEach((key, value) {
            if (value['categoria_id'] ==
                '${producto.categoria}_${producto.id}') {
              final int cantidadActual = value['cantidad'] as int;
              final int cantidadNueva = cantidadActual - cantidad;

              if (cantidadNueva <= 0) {
                // Si la cantidad resultante es menor o igual a cero, se elimina el producto
                productDbRef.child(key).remove();
              } else {
                // Si la cantidad resultante es mayor que cero, se actualiza la cantidad
                productDbRef.child(key).update({'cantidad': cantidadNueva});
              }
            }
          });
        }
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
    return count;
  }

  Future<int> getProductCount(String lista) async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    int productCount = 0;
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            if (value['titulo'] == lista) {
              if (value['productos'] != null) {
                final productos = value['productos'] as Map<dynamic, dynamic>;
                productos.forEach((key, value) {
                  productCount++;
                });
              }
            }
          });
        }
      }
    });
    return productCount;
  }

  Future<List<Producto>> getProducts(String lista) async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    List productosLista = [];
    List<Producto> productos = [];

    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            if (value['titulo'] == lista) {
              if (value['productos'] != null) {
                final productos = value['productos'] as Map<dynamic, dynamic>;
                productos.forEach((key, value) {
                  final categoriaId = value['categoria_id'];
                  final cantidad = value['cantidad'].toString();
                  final tienda = value['tienda'];

                  final productoData = {
                    'categoria_id': categoriaId,
                    'cantidad': cantidad,
                    'tienda': tienda,
                  };

                  productosLista.add(productoData);
                });
              }
            }
          });
        }
      }
    });

    for (var element in productosLista) {
      final String categoria = element['categoria_id'].split('_')[0];
      final String id = element['categoria_id'].split('_')[1];
      final String cantidad = element['cantidad'];
      final tienda = element['tienda'];

      final productoRef = _productosRef.child(categoria).child(id);
      final snapshot = await productoRef.get();
      final values = snapshot.value as Map<dynamic, dynamic>;

      productos.add(Producto(
        id: int.parse(id),
        nombre: values['nombre'],
        categoria: categoria,
        precios: values['precios'],
        imagen: values['image_path'],
        cantidad: int.parse(cantidad),
        tiendaSeleccionada: tienda,
      ));
    }

    return productos;
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

  Future<String> getProductsPrice(String lista) async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;

    int totalPrice = 0;
    List productosLista = [];
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) {
            if (value['titulo'] == lista) {
              if (value['productos'] != null) {
                final productos = value['productos'] as Map<dynamic, dynamic>;
                productos.forEach((key, value) {
                  final categoriaId = value['categoria_id'];
                  final cantidad = value['cantidad'].toString();
                  final tienda = value['tienda'];

                  final productoData = {
                    'categoria_id': categoriaId,
                    'cantidad': cantidad,
                    'tienda': tienda,
                  };

                  productosLista.add(productoData);
                });
              }
            }
          });
        }
      }
    });

    for (var element in productosLista) {
      final String categoria = element['categoria_id'].split('_')[0];
      final String id = element['categoria_id'].split('_')[1];
      final String cantidad = element['cantidad'];
      final tienda = element['tienda'];

      final productoRef = _productosRef.child(categoria).child(id);
      final snapshot = await productoRef.get();
      final values = snapshot.value as Map<dynamic, dynamic>;
      Producto producto = Producto(
          id: int.parse(id),
          nombre: values['nombre'],
          categoria: categoria,
          precios: values['precios'],
          imagen: values['image_path'],
          cantidad: int.parse(cantidad),
          tiendaSeleccionada: tienda);
      totalPrice += (producto.getPriceForStore(tienda) * int.parse(cantidad));
    }

    String result = formatPrice(totalPrice);
    return result;
  }

  Future<List<Listado>> getListados() async {
    final String? userEmail = _auth.currentUserEmail;
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    List<Listado> lists = [];
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        if (value['listas'] != null) {
          final listas = value['listas'] as Map<dynamic, dynamic>;
          listas.forEach((key, value) async {
            Listado lista = Listado(
                nombre: value['titulo'],
                precio: 0,
                imagen: 'https://i.ibb.co/6t98mmT/lista-de-deseos.png');
            lists.add(lista);
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
      count++;
      productosLista.add(producto);
    }
    return productosLista;
  }

  Future<List<Producto>> getAllProducts() async {
    final snapshot = await _productosRef.get();
    List<Producto> productos = [];
    for (var category in snapshot.children) {
      List<Producto> productosCategoria =
          await getProductsByCategory(category.key);
      productos.addAll(productosCategoria);
    }
    return productos;
  }

  Future<List<Producto>> getProductsByCategory(String? category) async {
    final dbRef = _productosRef.child(category!);
    final snapshot = await dbRef.get();
    int count = 0;
    List<Producto> productos = [];
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      Producto producto = Producto(
        id: count,
        nombre: values['nombre'],
        imagen: values['image_path'],
        categoria: category,
        precios: values['precios'],
      );
      productos.add(producto);
      count++;
    }
    return productos;
  }

  Future<int> getAllProductsCount() async {
    final snapshot = await _productosRef.get();
    int count = 0;
    for (var category in snapshot.children) {
      int categoryCount = await getProductsCountByCategory(category.key);
      count += categoryCount;
    }
    return count;
  }

  Future<int> getProductsCountByCategory(String? category) async {
    final dbRef = _productosRef.child(category!);
    final snapshot = await dbRef.get();
    int count = 0;
    // ignore: unused_local_variable
    for (var element in snapshot.children) {
      count++;
    }
    return count;
  }

  Future<List<Producto>> searchByCategory(
      String busqueda, String? category) async {
    final dbRef = _productosRef.child(category!);
    final snapshot = await dbRef.get();
    int count = 0;
    bool cumple = false;
    List<Producto> productos = [];
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (key == 'nombre') {
          if (RegExp(busqueda, caseSensitive: false).hasMatch(value)) {
            cumple = true;
            count++;
          }
        }
      });
      if (cumple) {
        Producto producto = Producto(
          id: count,
          nombre: values['nombre'],
          imagen: values['image_path'],
          categoria: category,
          precios: values['precios'],
        );
        productos.add(producto);
      }
      cumple = false;
    }
    return productos;
  }

  Future<List<Producto>> searchAll(String busqueda) async {
    final snapshot = await _productosRef.get();
    List<Producto> productos = [];
    for (var category in snapshot.children) {
      List<Producto> productosCategoria =
          await searchByCategory(busqueda, category.key);
      productos.addAll(productosCategoria);
    }
    return productos;
  }

  Future<int> searchCountByCategory(String busqueda, String? category) async {
    final dbRef = _productosRef.child(category!);
    final snapshot = await dbRef.get();
    int count = 0;
    for (var element in snapshot.children) {
      final values = element.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (key == 'nombre') {
          if (RegExp(busqueda, caseSensitive: false).hasMatch(value)) {
            count++;
          }
        }
      });
    }
    return count;
  }

  Future<void> addCommentToDatabase(String name, String comment) async {
    _feedbackRef.push().set({
      'nombre': name,
      'comentario': comment,
    });
  }

  Future<int> searchCountAll(String busqueda) async {
    final snapshot = await _productosRef.get();
    int count = 0;
    for (var category in snapshot.children) {
      int categoryCount = await searchCountByCategory(busqueda, category.key);
      count += categoryCount;
    }
    return count;
  }
}
