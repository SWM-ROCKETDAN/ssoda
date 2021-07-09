import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventImage extends StatefulWidget {
  List<String> imageList;
  EventImage({Key? key, required this.imageList}) : super(key: key);

  @override
  _EventImageState createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  Future getImageFromCam() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      widget.imageList.add(image!.path);
    });
  }

  Future getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      widget.imageList.add(image!.path);
    });
  }

  PickedFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
                child: widget.imageList.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: Colors.grey.shade300,
                        child: Center(
                            child: Row(
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 4),
                            Text('이미지를 등록해주세요')
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                      )
                    : Image.file(File(widget.imageList[0])))),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: getImageFromCam,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '촬영하기',
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade400),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0)))),
            )),
            SizedBox(width: 15),
            Expanded(
                child: ElevatedButton(
              onPressed: getImageFromGallery,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '불러오기',
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade400),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0)))),
            )),
          ],
        )
      ],
    );
  }
}
