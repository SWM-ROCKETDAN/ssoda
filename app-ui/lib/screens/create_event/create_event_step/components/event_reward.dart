import 'package:flutter/material.dart';
import 'package:hashchecker/models/reward.dart';
import '../../select_reward_category/select_reward_category_screen.dart';
import 'dart:io';

class EventReward extends StatefulWidget {
  final rewardList;
  const EventReward({Key? key, this.rewardList}) : super(key: key);

  @override
  _EventRewardState createState() => _EventRewardState();
}

class _EventRewardState extends State<EventReward> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 116,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.rewardList.length,
            padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemBuilder: (context, index) => widget.rewardList[index] == null
                ? SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        _navigateAndCategorySelection(context, index);
                      },
                      child: Stack(children: [
                        Center(
                            child: Icon(
                          Icons.add,
                          size: 45,
                          color: Colors.grey.shade400,
                        )),
                      ]),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade300),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                    ))
                : GestureDetector(
                    onTap: () {
                      _navigateAndCategorySelection(context, index);
                    },
                    child: Container(
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(widget.rewardList[index].imgPath),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 110,
                            color: Colors.black38,
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 1}단계',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                '등록 완료',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  )));
  }

  _navigateAndCategorySelection(BuildContext context, int index) async {
    final Reward? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectRewardCategoryScreen()));

    if (result != null) {
      setState(() {
        widget.rewardList[index] = result;
        widget.rewardList.add(null);
      });
    }
  }
}
