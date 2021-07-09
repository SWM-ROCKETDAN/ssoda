import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';
import 'dart:io';

class FooterWithImages extends StatelessWidget {
  const FooterWithImages({
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
          height: size.height * 0.4 - 45,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 50,
                    offset: Offset(0, 5),
                    color: Colors.black.withOpacity(0.35))
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              image: DecorationImage(
                  image: FileImage(File(event.images[0])), fit: BoxFit.cover)),
        ),
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
                        image: AssetImage('assets/images/bbq.jpg'),
                        fit: BoxFit.cover))))
      ]),
    );
  }
}
