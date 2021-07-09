import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/category.dart';
import '../../../models/reward.dart';
import 'dart:io';

class InputRewardInfoScreen extends StatefulWidget {
  final RewardCategory category;
  const InputRewardInfoScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _InputRewardInfoScreenState createState() => _InputRewardInfoScreenState();
}

class _InputRewardInfoScreenState extends State<InputRewardInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _countController;

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
    return Scaffold(appBar: buildAppBar(), body: buildBody(context));
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              buildInputName(),
              SizedBox(height: 25),
              buildChooseImage(),
              SizedBox(height: 10),
              buildInputPriceAndCount(),
            ],
          )),
          buildConfirmButton(context)
        ],
      ),
    );
  }

  SizedBox buildConfirmButton(BuildContext context) {
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
          Navigator.pop(
              context,
              Reward(
                  name: _nameController.value.text,
                  imgPath: _image!.path,
                  price: int.parse(_priceController.value.text),
                  count: int.parse(_countController.value.text),
                  category: widget.category));
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

  Column buildInputPriceAndCount() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              child: Row(children: [
                Icon(Icons.attach_money),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        cursorColor: Colors.indigoAccent.shade700,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: '단가',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.indigoAccent.shade700)),
                        ))),
                SizedBox(width: 10),
                Text('원', style: TextStyle(fontSize: 18))
              ])),
          SizedBox(height: 20),
          SizedBox(
              width: 150,
              child: Row(children: [
                Icon(Icons.toll),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        controller: _countController,
                        cursorColor: Colors.indigoAccent.shade700,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: '수량',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.indigoAccent.shade700)),
                        ))),
                SizedBox(width: 10),
                Text('개', style: TextStyle(fontSize: 18))
              ]))
        ]);
  }

  SizedBox buildChooseImage() {
    return SizedBox(
        height: 200,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.image),
              SizedBox(width: 15),
              Expanded(
                child: _image == null
                    ? Center(
                        child: Container(
                            width: 400,
                            color: Colors.grey.shade400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '보상 품목 사진을 등록해주세요',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                    onPressed: getImageFromGallery,
                                    child: Text(
                                      '업로드',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.grey.shade300),
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12)))))
                              ],
                            )))
                    : Image.file(File(_image!.path)),
              )
            ]));
  }

  SizedBox buildInputName() {
    return SizedBox(
        height: 50,
        child: Row(children: [
          Icon(Icons.star),
          SizedBox(width: 15),
          Expanded(
              child: TextField(
                  controller: _nameController,
                  cursorColor: Colors.indigoAccent.shade700,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '품명',
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent.shade700)),
                  )))
        ]));
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
