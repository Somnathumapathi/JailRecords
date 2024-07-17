import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jailerecord/constants/globalvariables.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/constants/utils.dart';
import 'package:jailerecord/features/auth/screens/signup.dart';
import 'package:jailerecord/features/auth/screens/signin.dart';
import 'package:jailerecord/features/lawyer/screens/lawyerHome.dart';
import 'package:jailerecord/features/police/screens/policeHome.dart';
import 'package:jailerecord/models/lawyer.dart';
import 'package:jailerecord/models/police.dart';
import 'package:jailerecord/provider/laywerProvider.dart';
import 'package:jailerecord/provider/policeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      httpHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User created now login');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SigninScreen()));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final UserCredential userCred = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        final uid = userCred.user!.uid;
        http.Response res = await http.get(Uri.parse('$uri/getUser?uid=$uid'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            });
        httpHandler(
            res: res,
            context: context,
            onSuccess: () async {
              print(res.body);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('uid', uid);
              await prefs.setString('role', jsonDecode(res.body)['role']);
              if (jsonDecode(res.body)['role'] == 'police') {
                final police = Police.fromMap(jsonDecode(res.body)['data'][0]);
                Provider.of<PoliceProvider>(context, listen: false)
                    .setPolice(police);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PoliceHome()));
              } else if (jsonDecode(res.body)['role'] == 'lawyer') {
                final lawyer = Lawyer.fromMap(jsonDecode(res.body)['data'][0]);
                Provider.of<LawyerProvider>(context, listen: false)
                    .setLawyer(lawyer);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LawyerHome()));
              }

              // showSnackBar(context, 'Successful');
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void signOut({required BuildContext context}) {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(
      context,
      (route) => false,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SigninScreen()));
  }
}
