import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';

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
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
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
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  children: [
                TextSpan(text: '총 '),
                TextSpan(
                    text: numberDisplay(eventReport.exposeCount),
                    style: TextStyle(color: kThemeColor, fontSize: 32)),
                TextSpan(text: ' 명에게 노출되었습니다'),
              ])),
          SizedBox(height: kDefaultPadding * 2),
          SizedBox(
            width: size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 40,
                      ),
                      Text(
                        '이벤트 참가자의',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    width: 155,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('평균 팔로워 수',
                                style: TextStyle(
                                  color: kThemeColor,
                                )),
                            Text(
                              '${numberDisplay(eventReport.followerAvg)}명',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kThemeColor,
                                  fontSize: 18),
                            )
                          ]),
                      SizedBox(height: kDefaultPadding / 3),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('총 팔로워 수',
                                style: TextStyle(
                                  color: kThemeColor,
                                )),
                            Text('${numberDisplay(eventReport.followerSum)}명',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kThemeColor,
                                    fontSize: 18))
                          ]),
                    ]),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
