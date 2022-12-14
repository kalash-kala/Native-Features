import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/models/places.dart';
import 'package:provider/provider.dart';

import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id as String);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title as String),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.images as File,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address as String,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                        initialLocation:
                            selectedPlace.location as PlaceLocation,
                        isSelecting: false,
                      )));
            },
            child: Text('View on Map'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.indigoAccent)),
          )
        ],
      ),
    );
  }
}
