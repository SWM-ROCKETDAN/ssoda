import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';
import 'package:hashchecker/screens/event_list/components/event_edit_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({
    Key? key,
    required this.index,
    required this.size,
    required this.eventList,
    required Map<EventStatus, String> statusStringMap,
    required Map<EventStatus, Color> statusColorMap,
  })  : _statusStringMap = statusStringMap,
        _statusColorMap = statusColorMap,
        super(key: key);

  final Size size;
  final int index;
  final List<EventListItem> eventList;
  final Map<EventStatus, String> _statusStringMap;
  final Map<EventStatus, Color> _statusColorMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 114,
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: size.width * 0.7,
                        padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                        height: 100,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AutoSizeText(
                                    eventList[index].title,
                                    style: TextStyle(
                                      color: kDefaultFontColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: kDefaultPadding / 3),
                                  Text(
                                      '${eventList[index].startDate} ~ ${eventList[index].finishDate}',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 12)),
                                  SizedBox(height: kDefaultPadding),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            _statusStringMap[
                                                eventList[index].status]!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: _statusColorMap[
                                                    eventList[index].status],
                                                fontWeight: eventList[index]
                                                            .status ==
                                                        EventStatus.PROCEEDING
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                        VerticalDivider(
                                            width: kDefaultPadding * 1.5,
                                            color:
                                                kShadowColor.withOpacity(0.6)),
                                        InkWell(
                                          onTap: () => showBarModalBottomSheet(
                                            expand: true,
                                            context: context,
                                            builder: (context) =>
                                                EventEditModal(),
                                          ),
                                          child: Icon(Icons.edit_rounded,
                                              color: Colors.blueGrey, size: 18),
                                        ),
                                        VerticalDivider(
                                            width: kDefaultPadding * 1.5,
                                            color:
                                                kShadowColor.withOpacity(0.6)),
                                        InkWell(
                                          onTap: () {
                                            showEventDeleteDialog(context);
                                          },
                                          child: Icon(Icons.delete_rounded,
                                              color: Colors.blueGrey, size: 18),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kShadowColor,
                                spreadRadius: 6,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: kScaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12)))),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.asset(
                          eventList[index].thumbnail,
                          width: size.width * 0.37,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kShadowColor,
                              spreadRadius: 6,
                              blurRadius: 20,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: kScaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12))),
                ),
              ],
            )),
        SizedBox(height: kDefaultPadding)
      ],
    );
  }

  void showEventDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트 삭제 시 이벤트가",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("즉시 종료되며 복구할 수 없습니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 삭제하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('삭제',
                          style: TextStyle(color: Colors.redAccent.shade400)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}
