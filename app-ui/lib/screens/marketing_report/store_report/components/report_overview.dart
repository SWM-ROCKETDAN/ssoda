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
        padding: const EdgeInsets.fromLTRB(35, 20, 40, 20),
        width: size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.attach_money,
                  size: 40,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('게시글 ', style: TextStyle(fontSize: 14)),
                  Text('1',
                      style: TextStyle(
                        color: kThemeColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(' 인 노출 당 ', style: TextStyle(fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.guestPrice.toString(),
                      duration: kDefaultNumberSliderDuration,
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text(' 원 사용', style: TextStyle(fontSize: 14))
                ]),
              ],
            ),
            SizedBox(height: kDefaultPadding / 3 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.group_outlined,
                  size: 40,
                ),
                Row(children: [
                  Text('총 ', style: TextStyle(fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.joinCount.toString(),
                      duration: kDefaultNumberSliderDuration,
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text(' 명 이벤트 참여', style: TextStyle(fontSize: 14))
                ]),
              ],
            ),
            SizedBox(height: kDefaultPadding / 3 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 40,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('누적 좋아요 ', style: TextStyle(fontSize: 14)),
                  NumberSlideAnimation(
                      number: storeReportOverview.likeCount.toString(),
                      duration: kDefaultNumberSliderDuration,
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      format: NumberFormatMode.comma),
                  Text(' 개', style: TextStyle(fontSize: 14))
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
