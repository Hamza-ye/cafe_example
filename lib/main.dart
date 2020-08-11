import 'package:cofe_example_firebase/screens/wrapper.dart';
import 'package:cofe_example_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
