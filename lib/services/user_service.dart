import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> syncUserWithFirestore() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);

    // Verifica si el usuario ya está en Firestore
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      // Si no existe, crea el documento
      await userDoc.set({
        'name': user.displayName ?? 'Usuario sin nombre',
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
