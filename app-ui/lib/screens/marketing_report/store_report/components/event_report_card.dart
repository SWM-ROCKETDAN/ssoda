import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/screens/marketing_report/event_report/event_report_screen.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/models/event_report_item.dart';

class EventReportCard extends StatelessWidget {
  const EventReportCard({
    Key? key,
    required this.index,
    required this.size,
    required this.eventReportList,
    required this.numberDisplay,
  }) : super(key: key);

  final int index;
  final Size size;
  final List<EventReportItem> eventReportList;
  final Display numberDisplay;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Card(
            color: Colors.white,
            elevation: 0.75,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventReportScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    child: Stack(
                      children: [
                        Image.asset(
                          eventReportList[index].thumbnail,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(4, 1, 4, 2),
                              width: 50,
                              child: Center(
                                child: Text(
                                  eventReportList[index].status ==
                                          EventStatus.PROCEEDING
                                      ? '진행 중'
                                      : '종료',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              color: eventReportList[index].status ==
                                      EventStatus.PROCEEDING
                                  ? Colors.greenAccent.shade700
                                  : Colors.grey.shade600,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eventReportList[index].eventName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: kDefaultPadding / 2),
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                size: 16,
                                color: Colors.black54,
                              ),
                              SizedBox(width: kDefaultPadding / 5),
                              Text(
                                '${numberDisplay(eventReportList[index].guestPrice)}원',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Icon(
                                Icons.group,
                                size: 16,
                                color: Colors.black54,
                              ),
                              SizedBox(width: kDefaultPadding / 3),
                              Text(
                                  '${numberDisplay(eventReportList[index].joinCount)}명',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14)),
                              SizedBox(width: kDefaultPadding / 2),
                              Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.black54,
                              ),
                              SizedBox(width: kDefaultPadding / 3),
                              Text(
                                  '${numberDisplay(eventReportList[index].likeCount)}개',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14)),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 3),
                          Wrap(
                              direction: Axis.horizontal,
                              spacing: 5.0,
                              children: List.generate(
                                eventReportList[index].rewardNameList.length,
                                (rewardIndex) => Chip(
                                  label: Text(
                                    eventReportList[index]
                                        .rewardNameList[rewardIndex],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  backgroundColor: kThemeColor.withOpacity(0.2),
                                ),
                              )),
                        ],
                      )),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))));
  }
}
