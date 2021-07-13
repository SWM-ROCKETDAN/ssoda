import 'package:flutter/material.dart';

class EventTitle extends StatefulWidget {
  final TextEditingController controller;
  const EventTitle({Key? key, required this.controller}) : super(key: key);

  @override
  _EventTitleState createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        cursorColor: Colors.indigoAccent.shade700,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.indigoAccent.shade700),
        decoration: InputDecoration(
          hintText: '우리가게 SNS 해시태그 이벤트',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.indigoAccent.shade700)),
        ));
  }
}
