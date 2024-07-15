import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Police {
  final int id;
  final String name;
  final String badge;
  final String uid;
  Police({
    required this.id,
    required this.name,
    required this.badge,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'badge': badge,
      'uid': uid,
    };
  }

  factory Police.fromMap(Map<String, dynamic> map) {
    return Police(
      id: map['id'] as int,
      name: map['name'] as String,
      badge: map['badge'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Police.fromJson(String source) =>
      Police.fromMap(json.decode(source) as Map<String, dynamic>);
}
