import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;

  Future<void> registrarUsuario({
    required String correo,
    required String contrasena,
  }) async {
    await _auth.createUserWithEmailAndPassword(
        email: correo, password: contrasena);
  }

  Future<void> autenticarUsuario({
    required String correo,
    required String contrasena,
  }) async {
    await _auth.signInWithEmailAndPassword(email: correo, password: contrasena);
  }

  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  // Getter for _auth
  FirebaseAuth get auth => _auth;

  // Getter for _user
  User? get currentUser => _user;

  // Getter for _user.email
  String? get currentUserEmail => _user?.email;
}
