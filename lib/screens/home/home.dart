import 'package:cofe_example_firebase/screens/home/brew_list.dart';
import 'package:cofe_example_firebase/screens/home/settings_form.dart';
import 'package:cofe_example_firebase/services/auth.dart';
import 'package:cofe_example_firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      final databaseService =
          Provider.of<DatabaseService>(context, listen: false);
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child:
                Provider.value(value: databaseService, child: SettingsForm()),
          );
        },
      );
    }

    final authService = Provider.of<AuthService>(context);
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
              await authService.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed: () async {
              _showSettingsPanel();
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()),
    );
  }
}
