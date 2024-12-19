import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstadoUsuario with ChangeNotifier {
  User? _user;

  User? get user => _user;

  EstadoUsuario() {
    // cambios en estado
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // cerrar sesion
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();  // Cierra sesión en Firebase
  _user = null;  // Limpia el usuario en memoria
  notifyListeners();  // Notifica a los listeners (por ejemplo, HomeScreen) de que el estado cambió
}


  // verificar usuario autenticado
  bool get isLoggedIn => _user != null;
}
