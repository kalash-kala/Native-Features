import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_features/models/places.dart';
import 'package:native_features/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlace(String? pickedTitle, File? pickedImage) {
    final newPlace = Places(
        id: DateTime.now().toString(),
        title: pickedTitle,
        images: pickedImage,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_place', {
      'id': newPlace.id as Object,
      'title': newPlace.title as Object,
      'image': newPlace.images!.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_place');
    _items = dataList
        .map((item) => Places(
            id: item['id'],
            title: item['title'],
            images: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }
}
