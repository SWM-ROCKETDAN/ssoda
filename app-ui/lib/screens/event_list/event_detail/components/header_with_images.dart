import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/screens/event_list/components/event_edit_modal.dart';
import 'dart:io';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HeaderWithImages extends StatelessWidget {
  const HeaderWithImages({Key? key, required this.size, required this.event})
      : super(key: key);

  final Size size;
  final Event event;

  @override
  Widget build(BuildContext context) {
    final double _statusBarHeight =
        MediaQuery.of(context).padding.top.toDouble();
    return Container(
      height: size.height * 0.4,
      child: Stack(children: [
        Container(
            color: kLiteFontColor,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: size.height * 0.4 - 15,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false),
              items: event.images
                  .map((item) => Center(
                      child: Image.asset(item!,
                          fit: BoxFit.cover, height: size.height * 0.4 - 15)))
                  .toList(),
            )),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.center,
                      end: FractionalOffset.topCenter,
                      colors: [
                        Colors.transparent.withOpacity(0.0),
                        Colors.black.withOpacity(0.6),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:
                      const EdgeInsets.fromLTRB(0, kToolbarHeight / 2, 5, 0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showBarModalBottomSheet(
                                expand: true,
                                context: context,
                                builder: (context) => EventEditModal(),
                              );
                            },
                            icon: Icon(Icons.edit,
                                color: Colors.white.withOpacity(0.8))),
                        SizedBox(width: kDefaultPadding / 3),
                        IconButton(
                            onPressed: () {
                              showEventDeleteDialog(context);
                            },
                            icon: Icon(Icons.delete,
                                color: Colors.white.withOpacity(0.8)))
                      ],
                    ),
                  ),
                ),
              ),
            )),
        Positioned(
            bottom: 14,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * 0.14 - 15,
              decoration: BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            )),
        Positioned(
            bottom: 0,
            right: size.width * 0.36,
            left: size.width * 0.36,
            child: Container(
                height: size.width * 0.28,
                width: size.width * 0.28,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25,
                          offset: Offset(0, 5),
                          color: kDefaultFontColor.withOpacity(0.2))
                    ],
                    color: kShadowColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/store_logo_sample.jpg'),
                        fit: BoxFit.cover))))
      ]),
    );
  }

  void showEventDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트 삭제 시 이벤트가",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("즉시 종료되며 복구할 수 없습니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 삭제하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('삭제',
                          style: TextStyle(color: Colors.redAccent.shade400)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}
