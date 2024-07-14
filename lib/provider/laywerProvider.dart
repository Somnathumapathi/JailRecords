import 'package:flutter/material.dart';
import 'package:jailerecord/models/lawyer.dart';

class LawyerProvider extends ChangeNotifier {
  Lawyer _lawyer = Lawyer(id: 0, name: '', contact: '', emailId: '', uid: '');
  Lawyer get laywer => _lawyer;
  void setLawyer(Lawyer lawyer) {
    _lawyer = lawyer;
    notifyListeners();
  }
}
