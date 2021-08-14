import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HeaderWithQrcode extends StatelessWidget {
  const HeaderWithQrcode({
    Key? key,
    required this.size,
    required this.qrcodeUrl,
  }) : super(key: key);

  final Size size;
  final String qrcodeUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.4 + size.width * 0.19,
      child: Stack(children: [
        Container(
          width: size.width,
          height: size.height * 0.4,
          child: ClipRRect(
              child: Image.asset(
                'assets/images/create_event_complete.png',
                fit: BoxFit.cover,
                //color: kThemeColor.withOpacity(0.3),
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(150))),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            color: kThemeColor.withOpacity(0.22),
          ),
        ),
        Positioned(
          child: Card(
            shadowColor: kShadowColor,
            elevation: 8,
            child: SizedBox(
                child: QrImage(
                  data: qrcodeUrl,
                  version: QrVersions.auto,
                ),
                height: size.width * 0.38,
                width: size.width * 0.38),
          ),
          bottom: 0,
          left: size.width * 0.3,
          right: size.width * 0.3,
        )
      ]),
    );
  }
}
