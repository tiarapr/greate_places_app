import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Great Places',
            style: const TextStyle(
                fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5), // Customize shadow color
        elevation: 4.0, // Adjust shadow intensity
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('No locations registered!'),
                ),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlaces.itemByIndex(index).image),
                              ),
                              title: Text(greatPlaces.itemByIndex(index).title),
                              subtitle: Text(greatPlaces
                                  .itemByIndex(index)
                                  .location),
                              onTap: () => Navigator.of(context).pushNamed(
                                AppRoutes.placeDetails,
                                arguments: greatPlaces.itemByIndex(index),
                              ),
                            ),
                          ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.addPlace),
        child: const Icon(Icons.add, color: Colors.white), // White icon
        backgroundColor: Colors.black, // Black background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Adjust as needed
        ),
      ),
    );
  }
}
