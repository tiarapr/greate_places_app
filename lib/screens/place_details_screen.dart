import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/great_places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;

    void _deletePlace(BuildContext ctx) {
      Provider.of<GreatPlaces>(context, listen: false).deletePlace(place.id);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Navigasi ke layar edit dengan membawa data tempat
              Navigator.of(context).pushNamed('/edit-place', arguments: place);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Tampilkan dialog konfirmasi untuk menghapus tempat
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Delete Place'),
                  content: Text('Are you sure you want to delete this place?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        _deletePlace(ctx);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            place.location,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              place.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
