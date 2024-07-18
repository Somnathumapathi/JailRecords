import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/constants/globalvariables.dart';
import 'package:jailerecord/constants/utils.dart';

class LawyerServices {
  static void joinCase(
      {required BuildContext context,
      required int caseId,
      required int lawyerId}) async {
    try {
      final res = await http.post(
        Uri.parse('$uri/joinCase'),
        body: jsonEncode({"caseId": caseId, "lawyerId": lawyerId}),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      print(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
