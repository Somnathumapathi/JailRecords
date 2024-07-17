import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jailerecord/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:jailerecord/models/case.dart';
import 'package:jailerecord/models/court.dart';

import '../../../constants/globalvariables.dart';

class PoliceServices {
  static void addCase(
      {required BuildContext context,
      required int prisoner_id,
      required String court_name,
      String? lawyer_id,
      String? documents,
      required int police_id}) async {
    try {
      print(jsonEncode({
        "prisoner_id": prisoner_id,
        "court_name": court_name,
        "police_id": police_id
      }));
      final res = await http.post(Uri.parse('$uri/createCase'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "prisoner_id": prisoner_id,
            "court_name": court_name,
            "police_id": police_id
          }));
      httpHandler(
          res: res,
          context: context,
          onSuccess: () {
            Navigator.pop(context);
            showSnackBar(context, 'Case added successfully');
          });
    } catch (e) {
      print(e.toString());
    }
  }

  static void createPrisoner(
      {required BuildContext context, required String prisonerName}) async {
    try {
      final res = await http.post(Uri.parse('$uri/addPrisoner'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({"name": prisonerName}));
      httpHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Prisoner successfully created with id: ${jsonDecode(res.body)['data']['id']}');
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  static Future<List<Case>?> getAllCases({
    required BuildContext context,
  }) async {
    try {
      final res = await http.get(Uri.parse('$uri/getAllCases'),
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
