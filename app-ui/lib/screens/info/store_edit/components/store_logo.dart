import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';
import 'package:image_picker/image_picker.dart';

class StoreLogo extends StatefulWidget {
  final Store store;
  const StoreLogo({Key? key, required this.store}) : super(key: key);

  @override
  _StoreLogoState createState() => _StoreLogoState();
}

class _StoreLogoState extends State<StoreLogo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _getImageFromGallery,
        child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: widget.store.logoImage
                            .substring(0, kNewImagePrefix.length) ==
                        kNewImagePrefix
                    ? DecorationImage(
                        image: FileImage(File(widget.store.logoImage
                            .substring(kNewImagePrefix.length))),
                        fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage('$s3Url${widget.store.logoImage}'),
                        fit: BoxFit.cover))));
  }

  void _getImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 75);
    if (image != null) {
      setState(() {
        widget.store.logoImage = '$kNewImagePrefix${image.path}';
      });
    }
  }
}
