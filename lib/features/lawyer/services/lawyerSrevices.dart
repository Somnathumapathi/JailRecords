import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/constants/globalvariables.dart';
import 'package:jailerecord/constants/utils.dart';

import '../../../models/case.dart';

class LawyerServices {
  static void joinCase(
      {required BuildContext context,
      required int caseId,
      required int lawyerId}) async {
    try {
      print(jsonEncode({"case_id": caseId, "lawyer_id": lawyerId}));
      final res = await http.patch(Uri.parse('$uri/joinCase'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({"case_id": caseId, "lawyer_id": lawyerId}));
      print(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<List<Case>?> getMyCases(
      {required BuildContext context, required int lawyerId}) async {
    try {
      print('reached111111');
      final res = await http.get(
          Uri.parse('$uri/getLawyersCases?lawyer_id=$lawyerId'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      print('hhyhhuhul');

      httpHandler(
          res: res,
          context: context,
          onSuccess: () {
            print(res.body);

            // return caseList;
          });
      final caseRes = jsonDecode(res.body)['data'] as List<dynamic>;
      final caseList =
          caseRes.map((e) => Case.fromJson(e as Map<String, dynamic>)).toList();

      print(caseList);
      return caseList;
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
