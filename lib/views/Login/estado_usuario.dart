import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstadoUsuario with ChangeNotifier {
  User? _user;

  User? get user => _user;

  EstadoUsuario() {
    // Inicializa autenticacion
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Cerrar sesion
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}

