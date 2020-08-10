import 'package:cofe_example_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either Auth or home
    return Authenticate();
  }
}
