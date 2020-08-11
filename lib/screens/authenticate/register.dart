import 'package:cofe_example_firebase/services/auth.dart';
import 'package:cofe_example_firebase/shared/constants.dart';
import 'package:cofe_example_firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Register'),
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
                  onPressed: widget.toggleView,
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Email'),
                      validator: (value) =>
                          value.isEmpty ? 'Must be filled out' : null,
                      onChanged: (value) => setState(() => email = value),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Password'),
                      validator: (value) =>
                          value.length < 6 ? 'Must be 6+ chars long' : null,
                      obscureText: true,
                      onChanged: (value) => setState(() => password = value),
                    ),
                    RaisedButton(
                      color: Colors.pink[500],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          error = '';
                        });
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await authService
                              .registerWithEmailAndPassword(email, password);
                          if (result is String)
                            setState(() {
                              loading = false;
                              error = result;
                            });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
