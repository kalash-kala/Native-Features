import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_features/models/places.dart';
import 'package:native_features/helpers/db_helper.dart';
import 'package:native_features/helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  Places findById(String id){
    return _items.firstWhere((places) => places.id==id);
  }

  Future<void> addPlace(String? pickedTitle, File? pickedImage, PlaceLocation? pickeLocation) async {

    final address = await LocationHelper.getPlaceAndAddress(pickeLocation!.latitude as double, pickeLocation!.longitude as double);
    final updatedLocation = PlaceLocation(latitude: pickeLocation.latitude, longitude: pickeLocation.longitude,address: address);
    final newPlace = Places(
        id: DateTime.now().toString(),
        title: pickedTitle,
        images: pickedImage,
        location: updatedLocation);
    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert('user_place', {
      'id': newPlace.id as Object,
      'title': newPlace.title as Object,
      'image': newPlace.images!.path,
      'loc_lat' : newPlace.location!.latitude as double,
      'loc_lng' : newPlace.location!.longitude as double,
      'address' : newPlace.location!.address as String
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_place');
    _items = dataList
        .map((item) => Places(
            id: item['id'],
            title: item['title'],
            images: File(item['image']),
            location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_lng'], address: item['address'])))
        .toList();
    notifyListeners();
  }
}
