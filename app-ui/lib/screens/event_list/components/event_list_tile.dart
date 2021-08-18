import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';

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
                                                    eventList[index].status])),
                                        VerticalDivider(
                                            width: kDefaultPadding * 1.5,
                                            color:
                                                kShadowColor.withOpacity(0.6)),
                                        Icon(Icons.share,
                                            color: kThemeColor.withOpacity(0.7),
                                            size: 18),
                                        VerticalDivider(
                                            width: kDefaultPadding * 1.5,
                                            color:
                                                kShadowColor.withOpacity(0.6)),
                                        Icon(Icons.edit,
                                            color: kThemeColor.withOpacity(0.7),
                                            size: 18),
                                        VerticalDivider(
                                            width: kDefaultPadding * 1.5,
                                            color:
                                                kShadowColor.withOpacity(0.6)),
                                        Icon(Icons.delete,
                                            color: kThemeColor.withOpacity(0.7),
                                            size: 18)
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
}
