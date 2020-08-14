import 'package:cofe_example_firebase/models/brew.dart';
import 'package:cofe_example_firebase/services/database.dart';
import 'package:cofe_example_firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);

    return StreamBuilder(
      stream: databaseService.brews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final List<Brew> brews = snapshot.data;
          return ListView.builder(
            itemCount: brews.length,
            itemBuilder: (context, index) {
              return BrewTile(brew: brews[index]);
            },
          );
        }
        return Center(
          child: Loading(),
        );
      },
    );
  }
}

class BrewTile extends StatelessWidget {
  const BrewTile({
    Key key,
    @required this.brew,
  }) : super(key: key);

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_icon.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              color: Colors.brown[brew.strength],
            ),
          ),
          title: Text(
            brew.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Takes ${brew.sugars} sugar(s)',
          ),
        ),
      ),
    );
  }
}
