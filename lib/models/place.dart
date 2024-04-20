import 'dart:io';

class Place {
  final String id;
  final String title;
  final String description;
  final String location;
  final String date;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.image,
  });
}
