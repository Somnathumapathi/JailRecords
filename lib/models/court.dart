// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Court {
  final int id;
  final String name;
  final String location;

  Court({required this.id, required this.name, required this.location});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
    };
  }

  factory Court.fromJson(Map<String, dynamic> map) {
    return Court(
      id: map['id'] as int,
      name: map['name'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Court.fromJson(String source) => Court.fromMap(json.decode(source) as Map<String, dynamic>);
}
