import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'components/body.dart';

class ShowQrcodeScreen extends StatefulWidget {
  final String eventId;
  const ShowQrcodeScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  _ShowQrcodeScreenState createState() => _ShowQrcodeScreenState();
}

class _ShowQrcodeScreenState extends State<ShowQrcodeScreen> {
  late String qrcodeUrl;

  @override
  void initState() {
    super.initState();
    qrcodeUrl = '$eventJoinUrl/${widget.eventId}';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Body(size: size, qrcodeUrl: qrcodeUrl));
  }
}
