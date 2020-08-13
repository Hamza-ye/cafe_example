import 'package:cofe_example_firebase/models/user.dart';
import 'package:cofe_example_firebase/screens/authenticate/authenticate.dart';
import 'package:cofe_example_firebase/screens/home/home.dart';
import 'package:cofe_example_firebase/services/auth.dart';
import 'package:cofe_example_firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.user,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return user == null
            ? Authenticate()
            : Provider<DatabaseService>(
                create: (context) => DatabaseService(uid: user.uid),
                child: Home(),
              );
      },
    );
  }
}
