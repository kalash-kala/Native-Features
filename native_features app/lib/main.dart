import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/places_list_screen.dart';
import 'package:native_features/screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.amber),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              onPrimary: Colors.black87
            ),
          )
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
