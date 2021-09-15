import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/screens/event_list/components/event_options_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'components/body.dart';

class EventDetailScreen extends StatefulWidget {
  final eventId;
  final eventStatus;
  const EventDetailScreen(
      {Key? key, required this.eventId, required this.eventStatus})
      : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late Future<Event> event;
  @override
  void initState() {
    super.initState();
    event = _fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: kDefaultFontColor),
          actions: [
            IconButton(
                onPressed: () => showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    expand: false,
                    context: context,
                    builder: (context) => EventOptionsModal(
                        eventId: widget.eventId,
                        eventStatus: widget.eventStatus,
                        isAlreadyInPreview: true)),
                icon: Icon(Icons.more_vert_rounded, color: kDefaultFontColor))
          ],
        ),
        body: FutureBuilder<Event>(
            future: event,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Body(event: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Center(child: const CircularProgressIndicator());
            }));
  }

  Future<List<Reward>> _fetchRewardListData() async {
    var dio = await authDio();

    final getRewardListResponse = await dio.get(
        getApi(API.GET_REWARD_OF_EVENT, suffix: '/${widget.eventId}/rewards'));

    final fetchedRewardList = getRewardListResponse.data;

    List<Reward> rewardList = List.generate(fetchedRewardList.length,
        (index) => Reward.fromJson(fetchedRewardList[index]));

    rewardList.sort((a, b) => a.level.compareTo(b.level));

    return rewardList;
  }

  Future<Event> _fetchEventData() async {
    List<Reward> _rewardList = await _fetchRewardListData();

    var dio = await authDio();

    final getEventResponse =
        await dio.get(getApi(API.GET_EVENT, suffix: '/${widget.eventId}'));

    final fetchedEvent = getEventResponse.data;

    Event event = Event.fromJson(fetchedEvent);
    event.rewardList = _rewardList;

    return event;
  }
}
