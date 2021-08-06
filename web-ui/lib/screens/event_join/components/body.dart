import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/screens/event_join/components/event_join_with_url.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'event_description.dart';
import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';

class Body extends StatefulWidget {
  final Map<String, dynamic> data;
  final id;
  const Body({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.data['rewards']);
    Size size = MediaQuery.of(context).size;

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: widget.data['event'].title,
    ));

    return LoadingOverlay(
      child: SingleChildScrollView(
          child: Column(
        children: [
          HeaderWithImages(size: size, data: widget.data),
          SizedBox(height: kDefaultPadding / 4 * 3),
          EventTitle(data: widget.data),
          SizedBox(height: kDefaultPadding),
          EventDescription(data: widget.data),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Divider(height: kDefaultPadding * 2, thickness: 1.5),
              EventRewards(data: widget.data),
              Divider(height: kDefaultPadding * 2, thickness: 1.5),
              EventHashtags(data: widget.data),
              Divider(height: kDefaultPadding * 2, thickness: 1.5),
              EventRequirements(data: widget.data),
              Divider(height: kDefaultPadding * 2, thickness: 1.5),
              EventPeriod(data: widget.data),
              Divider(height: kDefaultPadding * 2, thickness: 1.5),
              EventJoinWithUrl(
                  data: widget.data, id: widget.id, loading: _loading)
            ]),
          ),
        ],
      )),
      isLoading: _isLoading,
      color: Colors.black,
      opacity: 0.8,
      progressIndicator: Stack(children: [
        Positioned(
          top: size.height * 0.25 - 100,
          left: 0,
          right: 0,
          child: SizedBox(
              height: 100,
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: List.generate(
                        widget.data['rewards'].length,
                        (index) => RotateAnimatedText(
                            widget.data['rewards'][index].name,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            duration: const Duration(milliseconds: 1000)))),
              )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: kDefaultPadding),
              SizedBox(
                height: 40,
                child: DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText('잠시만 기다려주세요...',
                            speed: Duration(milliseconds: 200))
                      ],
                    )),
              ),
              SizedBox(height: kDefaultPadding / 3),
              Text(
                '과연 어떤 상품을 받게될까요?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void _loading(bool opt) {
    setState(() {
      _isLoading = opt;
    });
  }
}
