import 'package:cofe_example_firebase/models/user.dart';
import 'package:cofe_example_firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // create user based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } on PlatformException catch (err) {
      return err.message;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } on PlatformException catch (err) {
      return err.message;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: result.user.uid)
          .updateUserData('0', 'new brews member', 100);
      return _userFromFirebaseUser(result.user);
    } on PlatformException catch (err) {
      return err.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on PlatformException catch (err) {
      return err.message;
    }
  }
}
