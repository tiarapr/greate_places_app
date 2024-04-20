import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/edit_place_screen.dart';
import 'package:provider/provider.dart';

import 'providers/great_places.dart';
import 'screens/place_details_screen.dart';
import 'screens/place_list_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.addPlace: (_) => const AddPlaceScreen(),
          AppRoutes.editPlace: (_) => const EditPlaceScreen(),
          AppRoutes.placeDetails: (_) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
