import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';
import 'package:image_picker/image_picker.dart';

class StoreImage extends StatefulWidget {
  final Store store;
  final List<String> newImages;
  final List<String> deletedImagePaths;
  const StoreImage(
      {Key? key,
      required this.store,
      required this.newImages,
      required this.deletedImagePaths})
      : super(key: key);

  @override
  _StoreImageState createState() => _StoreImageState();
}

class _StoreImageState extends State<StoreImage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.image_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        SizedBox(
          height: 48,
          width: MediaQuery.of(context).size.width - 100,
          child: widget.store.images.length == 0
              ? Row(
                  children: [
                    buildAddButton(),
                    SizedBox(width: kDefaultPadding / 3 * 2),
                    Text('가게 이미지 등록',
                        style: TextStyle(color: kLiteFontColor, fontSize: 12))
                  ],
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index ==
                          widget.store.images.length
                      ? (widget.store.images.length < 3
                          ? buildAddButton()
                          : Container())
                      : GestureDetector(
                          onTap: () {
                            _removeStoreImage(index);
                          },
                          child: SizedBox(
                            height: 48,
                            child: ClipRRect(
                                child: widget.store.images[index]
                                        .startsWith(kNewImagePrefix)
                                    ? Image.file(
                                        File(widget.store.images[index]
                                            .substring(kNewImagePrefix.length)),
                                        fit: BoxFit.cover)
                                    : Image.network(
                                        '$s3Url${widget.store.images[index]}',
                                        fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: kDefaultPadding / 3),
                  itemCount: widget.store.images.length + 1),
        )
      ],
    );
  }

  SizedBox buildAddButton() {
    return SizedBox(
        height: 48,
        width: 48,
        child: ElevatedButton(
            onPressed: () async {
              await _addStoreImage();
            },
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.white24))));
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
        widget.store.images.add('$kNewImagePrefix${image.path}');
      });
      widget.newImages.add(image.path);
    }
  }

  void _removeStoreImage(int index) {
    setState(() {
      widget.store.images.removeAt(index);
    });

    widget.deletedImagePaths.add(widget.store.images[index]);
  }
}
