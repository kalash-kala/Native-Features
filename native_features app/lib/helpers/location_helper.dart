import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {

  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&${latitude},${longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C${latitude},${longitude}&key=AIzaSyDuAuxEURVXLGTbGJyMwOgwC63a_SXcQOE';
  }

  static Future<String> getPlaceAndAddress(double latitude, double longitude)async{
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=AIzaSyB7mSqylYD3EhmWXwtZH46u-eGy_Ib7oOM');
    final response = await http.get(url);
    //print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

}
