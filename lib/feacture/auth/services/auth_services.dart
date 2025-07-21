import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ LOGIN
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      } else {
        return e.message;
      }
    }
  }

  // ✅ REGISTER
  Future<String?> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await credential.user?.updateDisplayName(fullName.trim());

      // Also save in Firestore
      await _firestore.collection('users').doc(credential.user?.uid).set({
        'uid': credential.user?.uid,
        'name': fullName.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    }
  }

  // ✅ LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ✅ FETCH NAME & EMAIL TOGETHER
  Future<Map<String, String>> getUserData() async {
    final user = _auth.currentUser;

    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return {
          'name': doc['name'] as String? ?? user.displayName ?? "User",
          'email': doc['email'] as String? ?? user.email ?? "",
        };
      } else {
        return {
          'name': user.displayName ?? "User",
          'email': user.email ?? "",
        };
      }
    } else {
      return {
        'name': "User",
        'email': "",
      };
    }
  }
}
