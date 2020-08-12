import 'package:cofe_example_firebase/models/brew.dart';
import 'package:cofe_example_firebase/services/database.dart';
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
      initialData: List<Brew>(),
      stream: databaseService.brews,
      builder: (context, snapshot) {
        final List<Brew> brews = snapshot.data;
        return ListView.builder(
          itemCount: brews.length,
          itemBuilder: (context, index) {
            return BrewTile(brew: brews[index]);
          },
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
            width: 25,
            height: 25,
            decoration: BoxDecoration(
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
