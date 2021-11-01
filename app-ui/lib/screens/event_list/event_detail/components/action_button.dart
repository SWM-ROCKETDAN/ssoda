import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ActionButton extends StatelessWidget {
  final ScreenshotController screenshotController;
  const ActionButton({Key? key, required this.screenshotController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              child: AutoSizeText(
                '템플릿 이미지 저장',
                style: TextStyle(
                    color: kThemeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                minFontSize: 12,
              ),
              onPressed: () {
                _selectTemplateSize(context);
              },
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  overlayColor: MaterialStateProperty.all<Color>(
                      kThemeColor.withOpacity(0.2)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          side: BorderSide(color: kThemeColor)))),
            ),
          ),
        ),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              child: Text(
                '닫기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0)))),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveTemplateImage(BuildContext context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final result = await screenshotController.captureAndSave(tempPath);

    final success = await GallerySaver.saveImage(result!);

    context.showFlashBar(
        barType: success! ? FlashBarType.success : FlashBarType.error,
        icon: success
            ? const Icon(Icons.check_circle_rounded)
            : const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(
            success ? '이벤트 템플릿 이미지를 갤러리에 저장했습니다' : '템플릿 이미지 저장에 실패했습니다',
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }

  void _selectTemplateSize(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('템플릿 사이즈 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16 * 3,
                          width: 9 * 3,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ], color: Colors.white),
                        ),
                        SizedBox(height: kDefaultPadding / 3),
                        Text(
                          'A4 세로',
                          style: TextStyle(color: kLiteFontColor, fontSize: 10),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 9 * 3,
                          width: 16 * 3,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,

                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ], color: Colors.white),
                        ),
                        SizedBox(height: kDefaultPadding / 3),
                        Text('A4 가로',
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 10)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 12 * 3,
                          width: 12 * 3,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,

                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ], color: Colors.white),
                        ),
                        SizedBox(height: kDefaultPadding / 3),
                        Text('정사각형',
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('선택', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}
