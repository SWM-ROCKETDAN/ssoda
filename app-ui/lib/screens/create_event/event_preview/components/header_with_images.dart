import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';
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
          height: size.height * 0.4 - 15,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(event.images[0])), fit: BoxFit.cover)),
        ),
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
                        image:
                            AssetImage('assets/images/store_logo_sample.jpg'),
                        fit: BoxFit.cover))))
      ]),
    );
  }
}
