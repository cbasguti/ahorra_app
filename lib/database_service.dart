import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('usuarios');
  late final String _userKey;

  DatabaseService() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? userEmail = user?.email;

    _getUserKey(userEmail);
  }

  Future<void> _getUserKey(String? userEmail) async {
    final snapshot = await _dbRef.get();
    final values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      if (value['correo'] == userEmail) {
        _userKey = key;
      }
    });
  }

  Future<void> crearNuevaLista(String titulo) async {
    final newDbRef = _dbRef.child('$_userKey/listas');
    newDbRef.push().set({'titulo': titulo});
  }

  Future<int> getListsCount(String userEmail) async {
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

  Future<List> getLists(String userEmail) async {
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
    print(lists);
    return lists;
  }
}
