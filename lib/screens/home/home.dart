import 'package:cofe_example_firebase/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Home'),
        elevation: 0.0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
      body: Text('Home'),
    );
  }
}
