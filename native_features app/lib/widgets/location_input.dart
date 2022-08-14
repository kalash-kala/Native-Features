import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:native_features/helpers/location_helper.dart';
import 'package:native_features/screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  void _showPreview(double? latitude, double? longitude){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageURL = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude,locData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MapScreen(
              isSelecting: true,
            )));
    if(selectedLocation==null){
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey)),
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
                )),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        ),
      ],
    );
  }
}
