import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cofe_example_firebase/models/brew.dart';
import 'package:cofe_example_firebase/models/user.dart';

class DatabaseService {
  final String uid;
  // Collection reference
  final CollectionReference reference = Firestore.instance.collection('brews');

  DatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await reference
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  // List of brews from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) => snapshot.documents
      .map<Brew>((document) => Brew.fromSnapshot(document))
      .toList();
  // get brews stream
  Stream<List<Brew>> get brews {
    return reference.snapshots().map(_brewListFromSnapshot);
  }

  // userData from userdata snapshots stream
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) => UserData(
        uid: uid,
        name: snapshot.data['name'] ?? '',
        sugars: snapshot.data['sugars'] ?? '0',
        strength: snapshot.data['strength'] ?? 100,
      );

  // get user data
  Stream<UserData> get userData {
    return reference.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
