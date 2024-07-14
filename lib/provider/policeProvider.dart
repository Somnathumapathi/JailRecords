import 'package:flutter/material.dart';
import 'package:jailerecord/models/police.dart';

class PoliceProvider extends ChangeNotifier {
  Police _police = Police(id: '', name: '', badge: '', uid: '');
  Police get police => _police;
  void setPolice(Police police) {
    _police = police;
    notifyListeners();
  }
}
