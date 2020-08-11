import 'package:cofe_example_firebase/models/user.dart';
import 'package:cofe_example_firebase/screens/authenticate/authenticate.dart';
import 'package:cofe_example_firebase/screens/home/home.dart';
import 'package:cofe_example_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    // print('user uid: ${user?.uid}');
    // return either Auth or home
    return StreamBuilder<User>(
      stream: authService.user,
      builder: (context, snapshot) {
        // if(snapshot.connectionState == ConnectionState.active)
        final user = snapshot.data;
        return user == null ? Authenticate() : Home();
      },
    );
    // return user == null ? Authenticate() : Home();
  }
}
