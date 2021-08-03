import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/models/event.dart';
import 'dart:io';

class HeaderWithImages extends StatelessWidget {
  const HeaderWithImages({
    Key? key,
    required this.size,
    required this.event,
  }) : super(key: key);

  final Size size;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      child: Stack(children: [
        Container(
            color: Colors.black,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: size.height * 0.4 - 15,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false),
              items: event.images
                  .map((item) => Container(
                        child: Center(
                            child: Image.asset(item!,
                                fit: BoxFit.cover,
                                height: size.height * 0.4 - 15)),
                      ))
                  .toList(),
            )),
        Positioned(
            bottom: 14,
            right: 0,
            left: 0,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
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
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 50,
                          offset: Offset(0, 5),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/sample/storeLogo.jpg'),
                        fit: BoxFit.cover))))
      ]),
    );
  }
}
