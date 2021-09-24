import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_logo.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'components/create_button.dart';
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
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 75);
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      setState(() {
        _logoPath = croppedFile.path;
      });
    }
  }

  Future<void> _addStoreImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1280,
        maxWidth: 1280,
        imageQuality: 75);
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
      body: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('신규 가게 등록',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: IntrinsicHeight(
                    child: Column(children: [
                      Text("저장되지 않은 내용이 있습니다.",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                      SizedBox(height: kDefaultPadding / 5),
                      Text("그래도 나가시겠습니까?",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                    ]),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  actions: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('예',
                                style: TextStyle(
                                    color: kThemeColor, fontSize: 13)),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kThemeColor.withOpacity(0.2))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              shouldClose = false;
                              Navigator.of(context).pop();
                            },
                            child: Text('아니오', style: TextStyle(fontSize: 13)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kThemeColor)),
                          ),
                        ],
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))));
          return shouldClose;
        },
        child: Container(
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
              CreateButton(
                  logo: _logoPath,
                  imageList: _storeImageList,
                  category: _storeCategory,
                  name: _storeName,
                  address: _storeAddress,
                  description: _storeDescription),
            ],
          ),
        ),
      ),
    );
  }
}
