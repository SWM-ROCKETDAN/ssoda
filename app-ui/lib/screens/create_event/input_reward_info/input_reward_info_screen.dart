import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/reward.dart';
import 'dart:io';

import 'components/input_help.dart';
import 'components/name_input.dart';
import 'components/price_and_count_input.dart';

class InputRewardInfoScreen extends StatefulWidget {
  final Reward? reward;
  const InputRewardInfoScreen({Key? key, this.reward}) : super(key: key);

  @override
  _InputRewardInfoScreenState createState() => _InputRewardInfoScreenState();
}

class _InputRewardInfoScreenState extends State<InputRewardInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _countController;
  RewardCategory? _choosedCategory;
  String? _imagePath;

  Future _getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.reward != null) {
      setState(() {
        _nameController = TextEditingController(text: widget.reward!.name);
        _priceController =
            TextEditingController(text: widget.reward!.price.toString());
        _countController =
            TextEditingController(text: widget.reward!.count.toString());
        _imagePath = widget.reward!.imgPath;
        _choosedCategory = widget.reward!.category;
      });
    } else {
      _nameController = TextEditingController();
      _priceController = TextEditingController();
      _countController = TextEditingController();
      _choosedCategory = RewardCategory.DRINK;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imagePath == null
                        ? buildImageUploadButton()
                        : buildRewardImage(),
                    SizedBox(height: kDefaultPadding * 2),
                    buildCategorySelection(context),
                    SizedBox(height: kDefaultPadding / 3 * 2),
                    NameInput(nameController: _nameController),
                    SizedBox(height: kDefaultPadding / 3 * 4),
                    PriceAndCountInput(
                        priceController: _priceController,
                        countController: _countController),
                    SizedBox(height: kDefaultPadding),
                    InputHelp(),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
            ),
            buildAddRewardButton(context)
          ],
        ),
      ),
    );
  }

  SizedBox buildAddRewardButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        child: Text(
          '보상 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (isValidReward()) {
            Navigator.pop(
                context,
                Reward(
                    name: _nameController.value.text.trim(),
                    imgPath: _imagePath!,
                    price: int.parse(_priceController.value.text.trim()),
                    count: int.parse(_countController.value.text.trim()),
                    category: _choosedCategory!));
          }
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigoAccent.shade700),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  SizedBox buildCategorySelection(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          categoryTileList.length,
          (index) => GestureDetector(
            child: Container(
              width: 80,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    categoryTileList[index].icon,
                    color: categoryTileList[index].category == _choosedCategory
                        ? Colors.white
                        : Colors.black87,
                  ),
                  SizedBox(height: 8),
                  Text(
                    categoryTileList[index].name,
                    style: TextStyle(
                      color:
                          categoryTileList[index].category == _choosedCategory
                              ? Colors.white
                              : Colors.black87,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: categoryTileList[index].category == _choosedCategory
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
            ),
            onTap: () {
              setState(() {
                _choosedCategory = categoryTileList[index].category;
              });
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildRewardImage() {
    return GestureDetector(
      onTap: _getImageFromGallery,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(_imagePath!),
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          )),
    );
  }

  SizedBox buildImageUploadButton() {
    return SizedBox(
        height: 150,
        width: 150,
        child: ElevatedButton(
          onPressed: _getImageFromGallery,
          child: Stack(children: [
            Center(
              child: Icon(
                Icons.add,
                color: Colors.black45,
                size: 50,
              ),
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Text('상품 이미지 등록하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45, fontSize: 10)))
          ]),
          style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.black26)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
              elevation: MaterialStateProperty.all<double>(0)),
        ));
  }

  void _showValidationErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isValidReward() {
    if (_imagePath == null)
      _showValidationErrorSnackBar(context, '상품 이미지를 등록해주세요!');
    else if (_nameController.value.text.trim() == "")
      _showValidationErrorSnackBar(context, '상품명을 입력해주세요!');
    else if (_priceController.value.text.trim() == "")
      _showValidationErrorSnackBar(context, '상품 가격을 입력해주세요!');
    else if (_countController.value.text.trim() == "")
      _showValidationErrorSnackBar(context, '상품 수량을 입력해주세요!');
    else
      return true;
    return false;
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '보상 상세정보 등록',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true);
  }
}
