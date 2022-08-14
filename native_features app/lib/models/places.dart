import 'dart:io';

class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation(
      {this.address, required this.latitude, required this.longitude});
}

class Places {
  final String? id;
  final String? title;
  final PlaceLocation? location;
  final File? images;

  Places(
      {required this.id,
      required this.title,
      required this.images,
      required this.location});
}
