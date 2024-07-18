// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:jailerecord/models/court.dart';
import 'package:jailerecord/models/jail.dart';
import 'package:jailerecord/models/lawyer.dart';
import 'package:jailerecord/models/police.dart';
import 'package:jailerecord/models/prisoner.dart';

class Case {
  int? caseId;
  List<String>? documents;
  Police police;
  Lawyer? lawyer;
  Court court;
  Prisoner prisoner;
  Jail? jail;
  Case({
    this.caseId,
    this.documents,
    required this.police,
    this.lawyer,
    required this.court,
    required this.prisoner,
    this.jail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documents': documents,
      'police': police.toMap(),
      'lawyer': lawyer?.toMap(),
      'court': court.toMap(),
      'prisoner': prisoner.toMap(),
      'jail': jail?.toMap(),
    };
  }

  factory Case.fromJson(Map<String, dynamic> map) {
    return Case(
      caseId: map['id'] != null ? map['id'] as int : 1,
      documents:
          map['documents'] != null ? List<String>.from(map['documents']) : null,
      police: Police.fromMap(map['Police'] as Map<String, dynamic>),
      lawyer: map['Lawyer'] != null
          ? Lawyer.fromMap(map['Lawyer'] as Map<String, dynamic>)
          : null,
      court: Court.fromJson(map['Court'] as Map<String, dynamic>),
      prisoner: Prisoner.fromJson(map['Prisoners'] as Map<String, dynamic>),
      jail: map['Jail'] != null
          ? Jail.fromJson(map['Jail'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Case.fromJson(String source) => Case.fromMap(json.decode(source) as Map<String, dynamic>);
}
