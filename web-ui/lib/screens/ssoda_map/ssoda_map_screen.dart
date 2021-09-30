import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/store_event/store_event_screen.dart';

class SsodaMapScreen extends StatelessWidget {
  const SsodaMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InAppWebViewController? webViewController;
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        webViewController?.goBack();
        return false;
      },
      child: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                  'https://ssoda.notion.site/492cd8758ae44accb1986d25ee656ee5')),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialOptions: options,
        ),
      ),
    ));
  }
}
