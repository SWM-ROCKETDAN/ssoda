import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreImage extends StatelessWidget {
  final getImageFromGallery;
  final deleteImage;
  final imageList;
  const StoreImage(
      {Key? key,
      required this.getImageFromGallery,
      required this.deleteImage,
      required this.imageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.image_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        SizedBox(
          height: 48,
          width: MediaQuery.of(context).size.width - 100,
          child: imageList.length == 0
              ? Row(
                  children: [
                    buildAddButton(),
                    SizedBox(width: kDefaultPadding),
                    Text('가게 이미지 등록',
                        style: TextStyle(color: kLiteFontColor, fontSize: 12))
                  ],
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == imageList.length
                      ? (imageList.length < 3 ? buildAddButton() : Container())
                      : GestureDetector(
                          onTap: () {
                            deleteImage(index);
                          },
                          child: SizedBox(
                            height: 48,
                            child: ClipRRect(
                                child: Image.file(File(imageList[index])),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: kDefaultPadding / 3),
                  itemCount: imageList.length + 1),
        )
      ],
    );
  }

  SizedBox buildAddButton() {
    return SizedBox(
        height: 48,
        width: 48,
        child: ElevatedButton(
          onPressed: getImageFromGallery,
          child: Center(
            child: Icon(
              Icons.add,
              color: kLiteFontColor,
              size: 24,
            ),
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(0)),
              side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: kLiteFontColor)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(kScaffoldBackgroundColor),
              overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
              elevation: MaterialStateProperty.all<double>(0)),
        ));
  }
}
