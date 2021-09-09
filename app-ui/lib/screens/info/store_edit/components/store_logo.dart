import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_picker/image_picker.dart';

class StoreLogo extends StatelessWidget {
  final store;
  const StoreLogo({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getImageFromGallery,
      child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(File(logoPath!)), fit: BoxFit.cover))),
    );
  }

  void _getImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 75);
    if (image != null) {
      setState(() {});
    }
  }
}
