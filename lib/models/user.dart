import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;
  DocumentReference reference;

  UserData({this.uid, this.name, this.sugars, this.strength});

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    UserData userData = UserData.fromJson(snapshot.data);
    userData.reference = snapshot.reference;
    return userData;
  }

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      name: json['name'] ?? '',
      sugars: json['sugars'] ?? '0',
      strength: json['strength'] ?? 0);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'sugars': sugars, 'name': name, 'strength': strength};

  @override
  String toString() =>
      'userData: {sugars: $sugars, name: $name, strength: $strength}';
}
