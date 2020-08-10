import 'package:cofe_example_firebase/models/user.dart';
import 'package:cofe_example_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print('user uid: ${user?.uid}');
    // return either Auth or home
    return Authenticate();
  }
}
