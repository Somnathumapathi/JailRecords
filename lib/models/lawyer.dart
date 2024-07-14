import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Lawyer {
  final int id;
  final String name;
  final String contact;
  final String emailId;
  final String uid;
  Lawyer({
    required this.id,
    required this.name,
    required this.contact,
    required this.emailId,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'contact': contact,
      'emailId': emailId,
      'uid': uid,
    };
  }

  factory Lawyer.fromMap(Map<String, dynamic> map) {
    return Lawyer(
      id: map['id'] as int,
      name: map['name'] as String,
      contact: map['contact'] as String,
      emailId: map['emailId'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lawyer.fromJson(String source) =>
      Lawyer.fromMap(json.decode(source) as Map<String, dynamic>);
}
