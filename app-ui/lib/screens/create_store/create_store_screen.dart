import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_logo.dart';
import 'package:image_picker/image_picker.dart';

import 'components/next_button.dart';
import 'components/store_description.dart';
import 'components/store_image.dart';
import 'components/store_location.dart';
import 'components/store_name.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({Key? key}) : super(key: key);

  @override
  _CreateStoreScreenState createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  String? _logoPath;
  List<String> _storeImageList = [];
  StoreCategory _storeCategory = StoreCategory.RESTAURANT;
  String? _storeName;
  Address? _storeAddress;
  TextEditingController _storeZipCodeController = TextEditingController();
  TextEditingController _storeAddressController = TextEditingController();
  String? _storeDescription;

  Future<void> _setLogoImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoPath = image.path;
      });
    }
  }

  Future<void> _addStoreImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _storeImageList.add(image.path);
      });
    }
  }

  void _deleteStoreImage(int index) {
    setState(() {
      _storeImageList.removeAt(index);
    });
  }

  void _setCategory(StoreCategory category) {
    setState(() {
      _storeCategory = category;
    });
  }

  void _setName(String name) {
    setState(() {
      _storeName = name;
    });
  }

  void _setDescription(String description) {
    setState(() {
      _storeDescription = description;
    });
  }

  void _setAddress(Address address) {
    _storeAddress = address;
    setState(() {
      _storeZipCodeController.text = address.zipCode;
      _storeAddressController.text =
          '${address.city} ${address.country} ${address.road} ${address.building}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '우리가게 등록',
            style: TextStyle(
                color: kDefaultFontColor, fontWeight: FontWeight.bold),
          )),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StoreLogo(
                        getImageFromGallery: _setLogoImage,
                        logoPath: _logoPath),
                    SizedBox(height: kDefaultPadding * 1.5),
                    StoreName(setName: _setName),
                    SizedBox(height: kDefaultPadding),
                    StoreCate(
                        setCategory: _setCategory, category: _storeCategory),
                    SizedBox(height: kDefaultPadding),
                    StoreImage(
                        getImageFromGallery: _addStoreImage,
                        deleteImage: _deleteStoreImage,
                        imageList: _storeImageList),
                    SizedBox(height: kDefaultPadding),
                    StoreLocation(
                        setAddress: _setAddress,
                        zipCodeController: _storeZipCodeController,
                        addressController: _storeAddressController),
                    SizedBox(height: kDefaultPadding),
                    StoreDescription(setDescription: _setDescription),
                  ],
                ),
              ),
            ),
            NextButton(
                logo: _logoPath,
                imageList: _storeImageList,
                category: _storeCategory,
                name: _storeName,
                address: _storeAddress,
                description: _storeDescription),
          ],
        ),
      ),
    );
  }
}
