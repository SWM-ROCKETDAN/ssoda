import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventImage extends StatefulWidget {
  final imageList;

  EventImage({Key? key, required this.imageList}) : super(key: key);

  @override
  _EventImageState createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  Future _getImageFromGallery(int index) async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (widget.imageList[index] == null && widget.imageList.length < 3)
        widget.imageList.add(null);
      widget.imageList[index] = image!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.25,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 2,
            autoPlay: false,
          ),
          items: List.generate(
              widget.imageList.length,
              (index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: GestureDetector(
                      onTap: () {
                        _getImageFromGallery(index);
                      },
                      child: widget.imageList[index] == null
                          ? ElevatedButton(
                              onPressed: () {
                                _getImageFromGallery(index);
                              },
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                color: Colors.black45,
                                size: 50,
                              )),
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black12),
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(color: Colors.black26))),
                            )
                          : Image.file(File(widget.imageList[index]),
                              fit: BoxFit.cover)))).cast<Widget>().toList(),
        )),
        SizedBox(height: kDefaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.black45),
            Text(
              ' 좌우 슬라이드로 최대 3장까지 등록할 수 있어요!',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}
