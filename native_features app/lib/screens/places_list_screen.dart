import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:provider/provider.dart';

import 'package:native_features/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Text('Got no places yet, start adding some'),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch as Widget
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                greatPlaces.items[index].images as File),
                          ),
                          title: Text(greatPlaces.items[index].title as String),
                        ),
                      ),
              ),
      ),
    );
  }
}
