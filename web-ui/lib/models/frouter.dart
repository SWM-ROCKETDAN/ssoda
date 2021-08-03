import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/screens/event_join/event_join_screen.dart';

class FRouter {
  static FluroRouter router = FluroRouter();

  static void setupRouter() {
    router.define('/:id',
        handler: Handler(
            handlerFunc: (context, params) =>
                EventJoinScreen(id: params['id']![0])),
        transitionType: TransitionType.fadeIn);
  }
}
