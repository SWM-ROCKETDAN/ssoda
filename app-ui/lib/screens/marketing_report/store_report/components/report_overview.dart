import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store_report_overview.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

class ReportOverview extends StatelessWidget {
  const ReportOverview({
    Key? key,
    required this.size,
    required this.storeReportOverview,
  }) : super(key: key);

  final Size size;
  final StoreReportOverview storeReportOverview;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 40,
                ),
                SizedBox(width: 10),
                Row(children: [
                  Text('1',
                      style: TextStyle(
                        color: kThemeColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('인 노출 당 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.guestPrice.toString(),
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text('원 사용',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ]),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.group_outlined,
                  size: 40,
                ),
                SizedBox(width: 10),
                Row(children: [
                  Text('총 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.joinCount.toString(),
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text('명 참여',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ]),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 40,
                ),
                SizedBox(width: 10),
                Row(children: [
                  Text('누적 좋아요 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.likeCount.toString(),
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text('개',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ]),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ]));
  }
}
