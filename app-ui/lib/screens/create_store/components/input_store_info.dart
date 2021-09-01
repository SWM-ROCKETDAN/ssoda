import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_store/components/store_logo.dart';
import 'package:image_picker/image_picker.dart';

import 'store_location.dart';
import 'store_name.dart';

class InputStoreInfoScreen extends StatefulWidget {
  const InputStoreInfoScreen({Key? key}) : super(key: key);

  @override
  _InputStoreInfoScreenState createState() => _InputStoreInfoScreenState();
}

class _InputStoreInfoScreenState extends State<InputStoreInfoScreen> {
  String? _logoPath;

  Future<void> _getImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoPath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '스토어 등록',
            style: TextStyle(
                color: kDefaultFontColor, fontWeight: FontWeight.bold),
          )),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StoreLogo(getImageFromGallery: _getImageFromGallery),
            SizedBox(height: kDefaultPadding * 2),
            StoreName(),
            SizedBox(height: kDefaultPadding),
            StoreLocation()
          ],
        ),
      ),
    );
  }
}
