import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/token.dart';
import 'package:hashchecker/screens/create_event/show_qrcode/show_qrcode_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreateEventButton extends StatelessWidget {
  final Event event;
  const CreateEventButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        child: Text(
          '이대로 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          final response = await http.post(
              Uri.parse(
                  getApi(API.CREATE_EVENT, parameter: "5")), // 5: store_id temp
              body: jsonEncode(event.toJson()),
              headers: {
                'x-auth-token': context.read<Token>().token!,
                "Accept": "application/json",
                "content-type": "application/json"
              });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowQrcodeScreen(
                eventId: response.body,
              ),
            ),
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }
}
