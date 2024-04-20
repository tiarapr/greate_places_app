import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(pickedImage.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  _selectPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(pickedImage.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('No images uploaded!'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text('Take a picture'),
              ),
              TextButton.icon(
                onPressed: _selectPicture,
                icon: const Icon(Icons.image),
                label: const Text('Select a picture'),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
