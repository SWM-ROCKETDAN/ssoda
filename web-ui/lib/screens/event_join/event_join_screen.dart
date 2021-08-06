import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/models/event.dart';
import 'components/body.dart';
import 'package:http/http.dart' as http;

class EventJoinScreen extends StatefulWidget {
  final id;
  const EventJoinScreen({Key? key, this.id}) : super(key: key);

  @override
  _EventJoinScreenState createState() => _EventJoinScreenState();
}

class _EventJoinScreenState extends State<EventJoinScreen> {
  late Future<Event> event;

  @override
  void initState() {
    super.initState();
    event = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Event>(
      future: event,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Body(event: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    ));
  }

  Future<Event> fetchEvent() async {
    final response = await http
        .get(Uri.parse(getApi(API.GET_EVENT, parameter: widget.id)), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Event.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('존재하지 않는 이벤트입니다.');
    }
  }
}
