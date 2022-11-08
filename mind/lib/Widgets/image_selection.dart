import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelection extends StatefulWidget {
  ImageSelection(this.imagePick);

  final void Function(File pickedImage) imagePick;

  @override
  State<ImageSelection> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageSelection> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePick(File(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 40,
              backgroundImage:
                  _pickedImage != null ? Image.file(_pickedImage!).image : null,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: _pickImage,
              child: Text(
                'Add Profile Picture',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
