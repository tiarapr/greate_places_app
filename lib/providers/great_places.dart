import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places/database/place_db.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  int _currentId = 0;

  Future<void> loadPlaces() async {
    final dataList = await DBUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
        id: item['id'],
        title: item['title'],
        description: item['description'],
        location: item['location'],
        date: item['date'],
        image: File(item['image']),
      ),
    )
        .toList();
    notifyListeners();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  Future<void> addPlace(
      String title, String description, String location, File image) async {
    final newId = _currentId++;
    var newPlace = Place(
      id: '$newId',
      title: title,
      description: description,
      date: DateTime.now().toString(),
      location: location,
      image: image,
    );

    _items.add(newPlace);

    // Simpan data ke dalam database
    await DBUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'description': newPlace.description,
        'location': newPlace.location,
        'date': newPlace.date,
        'image': newPlace.image.path,
      },
    );

    notifyListeners();
  }

  Future<void> updatePlace(Place updatedPlace) async {
    final placeIndex = _items.indexWhere((place) => place.id == updatedPlace.id);
    if (placeIndex >= 0) {
      _items[placeIndex] = updatedPlace;

      // Update data di database
      await DBUtil.update(
        'places',
        updatedPlace.id,
        {
          'title': updatedPlace.title,
          'description': updatedPlace.description,
          'location': updatedPlace.location,
          'date': updatedPlace.date,
          'image': updatedPlace.image.path,
        },
      );

      notifyListeners();
    } else {
      print('Could not find the place with id ${updatedPlace.id}');
    }
  }

  Future<void> deletePlace(String id) async {
    _items.removeWhere((place) => place.id == id);
    await DBUtil.delete('places', id);
    notifyListeners();
  }
}
