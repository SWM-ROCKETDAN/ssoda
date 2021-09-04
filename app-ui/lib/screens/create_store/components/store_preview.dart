import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';

class StorePreviewModal extends StatelessWidget {
  final Store store;
  const StorePreviewModal({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kScaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          '우리가게 미리보기',
          style: TextStyle(
              color: kDefaultFontColor,
              fontSize: 19,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          height: size.width / 16 * 9 + size.width * 0.1,
          color: kScaffoldBackgroundColor,
          child: Stack(children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: size.width / 16 * 9,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false),
              items: store.images
                  .map((item) => Container(
                        child: Center(
                            child: Stack(children: [
                          Image.file(
                            File(item),
                            fit: BoxFit.cover,
                            width: size.width,
                          ),
                          Container(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kScaffoldBackgroundColor,
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ))
                        ])),
                      ))
                  .toList(),
            ),
            Positioned(
                bottom: 0,
                right: size.width * 0.3,
                left: size.width * 0.3,
                child: Container(
                    height: size.width * 0.2,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 25,
                              spreadRadius: 10,
                              offset: Offset(0, -5),
                              color: kDefaultFontColor.withOpacity(0.2))
                        ],
                        color: kShadowColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(File(store.logoImage)),
                            fit: BoxFit.cover))))
          ]),
        ),
        SizedBox(height: kDefaultPadding * 1.2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              store.name,
              style: TextStyle(
                  color: kDefaultFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              maxLines: 1,
              minFontSize: 12,
            ),
            SizedBox(width: kDefaultPadding / 3),
            Icon(Icons.local_cafe_rounded, size: 18),
          ],
        ),
        SizedBox(height: kDefaultPadding / 2),
        Text(store.address.getFullAddress(),
            style: TextStyle(color: kLiteFontColor, fontSize: 14))
      ]),
    );
  }
}
