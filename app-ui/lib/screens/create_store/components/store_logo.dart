import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreLogo extends StatelessWidget {
  final VoidCallback getImageFromGallery;
  final String? logoPath;
  const StoreLogo({Key? key, required this.getImageFromGallery, this.logoPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        logoPath == null ? SizedBox(
            height: 75,
            width: 75,
            child: ElevatedButton(
              onPressed: getImageFromGallery,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: kLiteFontColor,
                  size: 32,
                ),
              ),
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: kLiteFontColor)),
                  shape:
                      MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor),
                  overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
                  elevation: MaterialStateProperty.all<double>(0)),
            )) : Container(height: 75,width: 75,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: ))),
        SizedBox(height: kDefaultPadding / 3 * 2),
        Text('가게 로고 등록', style: TextStyle(color: kLiteFontColor, fontSize: 12)),
      ],
    );
  }
}
