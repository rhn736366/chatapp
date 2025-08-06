import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email,
      String password,
      ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'lastLogin': Timestamp.now(),
        }, SetOptions(merge: true));
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    }
  }

  // Sign up with email, password, and name
  Future<UserCredential> signUpWithEmailPassword(
      String email,
      String password,
      String name,
      ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': name,
          'createdAt': Timestamp.now(),
        }, SetOptions(merge: true));
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Error code mapping to human-readable messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email is already in use.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An unexpected error occurred: $code';
    }
  }
}
