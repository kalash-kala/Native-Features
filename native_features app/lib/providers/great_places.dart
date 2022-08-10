import 'package:flutter/foundation.dart';
import 'package:native_features/models/places.dart';

class GreatPlaces with ChangeNotifier{

  List<Places> _items = [];

  List<Places> get items{
    return [..._items];
  }

}