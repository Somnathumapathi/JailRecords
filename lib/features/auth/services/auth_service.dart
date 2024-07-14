import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {} catch (e) {
      print(e);
    }
  }

  static void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final uid = userCred.user!.uid;
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
