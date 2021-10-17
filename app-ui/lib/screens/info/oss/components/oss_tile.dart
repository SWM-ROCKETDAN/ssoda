import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/oss.dart';
import 'package:url_launcher/url_launcher.dart';

class OssList extends StatefulWidget {
  final index;
  const OssList({Key? key, required this.index}) : super(key: key);

  @override
  _OssListState createState() => _OssListState();
}

class _OssListState extends State<OssList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 250),
      dividerColor: kDefaultFontColor,
      elevation: 0,
      expansionCallback: (item, status) {
        setState(() {
          ossList[widget.index].isExpanded = !ossList[widget.index].isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: kScaffoldBackgroundColor,
          headerBuilder: (context, isExpanded) => Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ossList[widget.index].name,
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: kDefaultPadding / 5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: ossList[widget.index].link,
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(ossList[widget.index].link);
                          })),
                SizedBox(height: kDefaultPadding / 10),
                Text(ossList[widget.index].license.getLicenseName(),
                    style: TextStyle(
                        color: kLiteFontColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Text(
                  ossList[widget.index].copyright,
                  style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: Text(ossList[widget.index].license.getLicenseDescription(),
                style: TextStyle(fontSize: 12)),
          ),
          isExpanded: ossList[widget.index].isExpanded,
        )
      ],
    );
  }
}
