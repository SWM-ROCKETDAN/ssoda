import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/reward.dart';
import 'dart:io';

class InputRewardInfoScreen extends StatefulWidget {
  const InputRewardInfoScreen({Key? key}) : super(key: key);

  @override
  _InputRewardInfoScreenState createState() => _InputRewardInfoScreenState();
}

class _InputRewardInfoScreenState extends State<InputRewardInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _countController;
  RewardCategory? _choosedCategory;

  PickedFile? _image;

  Future getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _countController = TextEditingController();
    if (_choosedCategory == null) _choosedCategory = RewardCategory.DRINK;
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
                child: Column(children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  color: categoryTileList[index].category ==
                                          _choosedCategory
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  categoryTileList[index].name,
                                  style: TextStyle(
                                    color: categoryTileList[index].category ==
                                            _choosedCategory
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: categoryTileList[index].category ==
                                      _choosedCategory
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _choosedCategory =
                                  categoryTileList[index].category;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(children: [
                      Icon(Icons.image_outlined),
                      ElevatedButton(
                          onPressed: () {},
                          child: Center(child: Icon(Icons.add))),
                    ]),
                  ),
                  SizedBox(height: 15),
                  TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.sell_outlined),
                          labelText: '상품명')),
                  SizedBox(height: 15),
                  TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                          labelText: '단가(원)')),
                  SizedBox(height: 15),
                  TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.toll_outlined),
                          labelText: '수량(개)'))
                ]),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                child: Text(
                  '보상 등록하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(
                      context,
                      Reward(
                          name: _nameController.value.text,
                          imgPath: _image!.path,
                          price: int.parse(_priceController.value.text),
                          count: int.parse(_countController.value.text),
                          category: _choosedCategory!));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.indigoAccent.shade700),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27.0)))),
              ),
            )
          ],
        ),
      ),
    );
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
