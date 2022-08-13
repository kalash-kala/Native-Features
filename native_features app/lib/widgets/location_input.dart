import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.blueGrey)),
          child: _previewImageURL == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageURL as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
            ),TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
            ),
          ],
        ),
      ],
    );
  }
}
