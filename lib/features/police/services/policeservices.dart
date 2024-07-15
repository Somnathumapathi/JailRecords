import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jailerecord/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/models/case.dart';
import 'package:jailerecord/models/court.dart';

import '../../../constants/globalvariables.dart';

class PoliceServices {
  static void addCase({
    required BuildContext context,
    required int prisoner_id,
    required String court_name,
    String? lawyer_id,
    String? documents,
    required int police_id
  }) async {

  }

  static Future<List<Case>?> getAllCases({
required BuildContext context,

  }) async {
try {
final res = await http.get(Uri.parse('$uri/getAllCases'), headers: {'Content-Type': 'application/json; charset=UTF-8'});
httpHandler(res: res, context: context, onSuccess: () {
  print(res.body);
  final caseRes = (jsonDecode(res.body)['data']);
  final caseList = caseRes.map((e)=> Case.fromJson(e));
  print(caseList);
  
});
} catch (e) {
  showSnackBar(context, e.toString());
}
  }
}
