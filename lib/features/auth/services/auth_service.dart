import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jailerecord/constants/globalvariables.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/constants/utils.dart';
import 'package:jailerecord/features/auth/screens/signup.dart';
import 'package:jailerecord/features/auth/screens/signin.dart';

class AuthService {
  static void signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      String? contact,
      String? badge,
      required String role}) async {
    try {
      final UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCred.user!.uid;
      print('rrrrrrrre');
      http.Response res = await http.post(Uri.parse('$uri/addNewUser'),
          body: jsonEncode({
            "name": name,
            "role": role,
            'emailId': email,
            'uid': uid,
            "badge": badge,
            "contact": contact
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      print('$uri/addNewUser');
      print('qenrojf');
      httpHandler(
          res: res,
          context: context,
          onSuccess: () {
            print('hbohqb');
            showSnackBar(context, 'User created now login');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SigninScreen()));
          });
    } catch (e) {
      print('erreeeeeeeeeeeeeerrrrrrrr');
      showSnackBar(context, e.toString());
    }
  }

  static void signin(
      {required BuildContext context,
      required String email,
      required String password,
      required String role}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final UserCredential userCred = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        final uid = userCred.user!.uid;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // if (role == 'police') {
    // } else if (role == 'laywer') {}
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
