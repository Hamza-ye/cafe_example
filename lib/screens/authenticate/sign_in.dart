import 'package:cofe_example_firebase/services/auth.dart';
import 'package:cofe_example_firebase/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key key, this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Sign in'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
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
                decoration: textInputDecoration.copyWith(labelText: 'Email'),
                validator: (value) =>
                    value.isEmpty ? 'Must be filled out' : null,
                onChanged: (value) => setState(() => email = value),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                validator: (value) =>
                    value.isEmpty ? 'Must be filled out' : null,
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
              ),
              RaisedButton(
                color: Colors.pink[500],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() {
                    error = '';
                  });
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _authService
                        .signInWithEmailAndPassword(email, password);
                    if (result is String)
                      setState(() {
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
