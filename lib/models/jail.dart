// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Jail {
  final int id;
  final String name;
  final String location;
  final int capacity;

  Jail(
      {required this.id,
      required this.name,
      required this.location,
      required this.capacity});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
      'capacity': capacity,
    };
  }

  factory Jail.fromJson(Map<String, dynamic> map) {
    return Jail(
      id: map['id'] as int,
      name: map['name'] as String,
      location: map['location'] as String,
      capacity: map['capacity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Jail.fromJson(String source) => Jail.fromMap(json.decode(source) as Map<String, dynamic>);
}
