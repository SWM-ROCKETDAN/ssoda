import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/reward.dart';
import 'dart:io';

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
                        ? SizedBox(
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
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 10)))
                              ]),
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black12),
                                  elevation:
                                      MaterialStateProperty.all<double>(3)),
                            ))
                        : GestureDetector(
                            onTap: _getImageFromGallery,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(_imagePath!),
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                )),
                          ),
                    SizedBox(height: 30),
                    SizedBox(
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
                                    : Colors.transparent,
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
                    SizedBox(height: 10),
                    TextField(
                        textAlign: TextAlign.start,
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.sell_outlined),
                            labelText: '상품명')),
                    SizedBox(height: 20),
                    SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.monetization_on_outlined),
                                    labelText: '단가',
                                    suffixText: '원'),
                              ),
                            ),
                            SizedBox(height: 15),
                            Expanded(
                              child: TextField(
                                  textAlign: TextAlign.end,
                                  controller: _countController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.toll_outlined),
                                      labelText: '수량',
                                      suffixText: '개')),
                            ),
                          ],
                        )),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Row(children: [
                            Icon(Icons.help_outline),
                            Text('  단가와 수량',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                          content: const Text(
                              '추후 마케팅 성과 측정 및 이벤트 조기 종료를 파악하기 위해 입력하는 정보이며 이벤트에 참여하는 고객들에게는 공개되지 않습니다.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('확인'),
                            ),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.help_outline,
                              size: 12,
                              color: Colors.black54,
                            ),
                            Text(
                              ' 단가와 수량은 왜 입력하나요?',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
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
                  if (isValidReward()) {
                    Navigator.pop(
                        context,
                        Reward(
                            name: _nameController.value.text.trim(),
                            imgPath: _imagePath!,
                            price:
                                int.parse(_priceController.value.text.trim()),
                            count:
                                int.parse(_countController.value.text.trim()),
                            category: _choosedCategory!));
                  }
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
