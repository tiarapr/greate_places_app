import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/great_places.dart';

class EditPlaceScreen extends StatefulWidget {
  const EditPlaceScreen({Key? key}) : super(key: key);

  @override
  State<EditPlaceScreen> createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Place place = ModalRoute.of(context)!.settings.arguments as Place;
      _titleController.text = place.title;
      _descriptionController.text = place.description;
      _locationController.text = place.location;
    });
  }

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _saveChanges() {
    final title = _titleController.text;
    final desc = _descriptionController.text;
    final location = _locationController.text;

    // Periksa apakah terdapat perubahan pada gambar
    final image = _pickedImage ?? (ModalRoute.of(context)!.settings.arguments as Place).image;

    // Dapatkan data tanggal dari objek Place yang sedang diedit
    final date = (ModalRoute.of(context)!.settings.arguments as Place).date;

    // Dapatkan ID dari objek Place yang sedang diedit
    final id = (ModalRoute.of(context)!.settings.arguments as Place).id;

    // Buat objek Place baru dengan data yang telah diedit
    final editedPlace = Place(
      id: id,
      title: title,
      description: desc,
      location: location,
      date: DateTime.now().toString(),
      image: image, // Gunakan gambar yang telah diubah atau asli jika tidak ada perubahan
    );

    // Panggil metode untuk menyimpan perubahan ke penyedia data
    Provider.of<GreatPlaces>(context, listen: false).updatePlace(editedPlace);

    // Tutup layar edit setelah perubahan disimpan
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Title',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      controller: _titleController,
                      onChanged: (value) => setState(() {}),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLines: 20,
                      controller: _descriptionController,
                      onChanged: (value) => setState(() {}),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Location',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      controller: _locationController,
                      onChanged: (value) => setState(() {}),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Image',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ImageInput(_selectImage),
                    const SizedBox(height: 12),
                    // LocationInput(_selectPosition),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
