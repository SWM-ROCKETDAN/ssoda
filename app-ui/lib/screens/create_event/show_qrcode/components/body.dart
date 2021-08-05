import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

import 'done_button.dart';
import 'header_with_qrcode.dart';
import 'message_field.dart';
import 'qr_image_save_button.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.size,
    required this.qrcodeUrl,
  }) : super(key: key);

  final Size size;
  final String qrcodeUrl;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderWithQrcode(size: size, qrcodeUrl: qrcodeUrl),
      SizedBox(height: kDefaultPadding),
      QrImageSaveButton(qrcodeUrl: qrcodeUrl),
      SizedBox(height: kDefaultPadding),
      MessageField(),
      DoneButton()
    ]);
  }
}
