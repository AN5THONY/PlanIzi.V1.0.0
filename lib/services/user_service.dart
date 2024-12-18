import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // aceptar todos los datos
  Future<void> syncUserWithFirestore(
    String name,
    String lastName,
    String email,
    DateTime? birthDate,
    String gender,
  ) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);

    // verificar usuario
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      // si no existe, se crea
      await userDoc.set({
        'name': name,
        'lastName': lastName,
        'email': email,
        'birthDate': birthDate,
        'gender': gender,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
