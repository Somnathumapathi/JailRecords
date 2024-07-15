// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Prisoner {
  final int id;
  final String name;
  final bool? status;

  Prisoner({required this.id, required this.name, this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory Prisoner.fromJson(Map<String, dynamic> map) {
    return Prisoner(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] != null ? map['status'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Prisoner.fromJson(String source) => Prisoner.fromMap(json.decode(source) as Map<String, dynamic>);
}
