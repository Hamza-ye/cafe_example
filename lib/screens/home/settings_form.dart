import 'package:cofe_example_firebase/models/user.dart';
import 'package:cofe_example_firebase/services/database.dart';
import 'package:cofe_example_firebase/shared/constants.dart';
import 'package:cofe_example_firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentSugars;
  String _currentName;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);
    return StreamBuilder<UserData>(
        stream: databaseService.userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Name'),
                    initialValue: _currentName ?? userData?.name,
                    validator: (value) =>
                        value.isEmpty ? 'Must be filled out' : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration.copyWith(
                        labelText: 'The amount of sugars'),
                    value: _currentSugars ?? userData.sugars,
                    items: sugars
                        .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text('$value sugars'),
                                ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _currentSugars = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Slider
                  Slider(
                    value: (_currentStrength ?? userData.strength)?.toDouble(),
                    label: '$_currentStrength',
                    divisions: 8,
                    min: 100.0,
                    max: 900.0,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[100],
                    onChanged: (value) =>
                        setState(() => _currentStrength = value.toInt()),
                  ),
                  // Botton
                  RaisedButton(
                    color: Colors.pink[500],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await databaseService.updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
