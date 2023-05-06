import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'auth/auth_service.dart';

class DatabaseService {
  final _dbRef = FirebaseDatabase.instance.ref().child('usuarios');
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
}
