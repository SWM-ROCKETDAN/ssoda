import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

class ExposureReport extends StatelessWidget {
  ExposureReport({
    Key? key,
    required this.size,
    required this.eventReport,
  }) : super(key: key);

  final Size size;
  final EventReport eventReport;
  final numberDisplay = createDisplay();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(1.5, 1.5),
          blurRadius: 2,
          spreadRadius: 0,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 5.0,
            children: [
              Text('총 ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              NumberSlideAnimation(
                  number: eventReport.exposeCount.toString(),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOut,
                  textStyle: TextStyle(
                      color: kThemeColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                  format: NumberFormatMode.comma),
              Text(
                ' 명에게 ',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                '노출되었습니다',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Icon(
                    Icons.person_outline,
                    size: 36,
                  ),
                  Row(
                    children: [
                      Text('1',
                          style: TextStyle(
                            color: kThemeColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('인 노출 당 ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      NumberSlideAnimation(
                          number:
                              (eventReport.costSum ~/ eventReport.exposeCount)
                                  .toString(),
                          duration: const Duration(seconds: 3),
                          curve: Curves.easeOut,
                          textStyle: TextStyle(
                              color: kThemeColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                          format: NumberFormatMode.comma),
                      Text('원 사용',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))
                    ],
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
