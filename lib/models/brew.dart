import 'package:cloud_firestore/cloud_firestore.dart';

class Brew {
  final String sugars;
  final String name;
  final int strength;
  DocumentReference reference;

  Brew(this.sugars, this.name, this.strength, {this.reference});

  factory Brew.fromSnapshot(DocumentSnapshot snapshot) {
    Brew brew = Brew.fromJson(snapshot.data);
    brew.reference = snapshot.reference;
    return brew;
  }

  factory Brew.fromJson(Map<String, dynamic> json) =>
      Brew(json['sugars'] ?? '0', json['name'] ?? '', json['strength'] ?? 0);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'sugars': sugars, 'name': name, 'strength': strength};

  @override
  String toString() =>
      'brew: {sugars: $sugars, name: $name, strength: $strength}';
}
