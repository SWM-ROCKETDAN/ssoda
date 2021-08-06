import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/token.dart';
import 'package:hashchecker/screens/create_event/show_qrcode/show_qrcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateEventButton extends StatelessWidget {
  final Event event;
  const CreateEventButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        child: Text(
          '이대로 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          var dio = Dio();

          dio.options.contentType = 'multipart/form-data';
          dio.options.headers['x-auth-token'] = context.read<Token>().token!;

          var eventData = FormData.fromMap({
            'title': event.title,
            'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss')
                .format(event.period.startDate),
            'finishDate': event.period.finishDate == null
                ? null
                : DateFormat('yyyy-MM-ddTHH:mm:ss')
                    .format(event.period.finishDate!),
            'images': List.generate(event.images.length,
                (index) => MultipartFile.fromFileSync(event.images[index]!)),
            'hashtags': event.hashtagList,
            'requirements': event.requireList,
            'template': event.template.id
          });

          var eventResponse = await dio
              .post(getApi(API.CREATE_EVENT, parameter: "1"), data: eventData);

          if (eventResponse.statusCode != 200) print('이벤트 생성 오류');
          var rewardsData = FormData();

          for (int i = 0; i < event.rewardList.length; i++) {
            if (event.rewardList[i] == null) continue;
            rewardsData.fields
                .add(MapEntry('rewards[$i].name', event.rewardList[i]!.name));
            rewardsData.fields.add(MapEntry(
                'rewards[$i].level', event.rewardList[i]!.level.toString()));
            rewardsData.fields.add(MapEntry(
                'rewards[$i].price', event.rewardList[i]!.price.toString()));
            rewardsData.fields.add(MapEntry(
                'rewards[$i].count', event.rewardList[i]!.count.toString()));
            rewardsData.fields.add(MapEntry('rewards[$i].category',
                event.rewardList[i]!.category.index.toString()));
            rewardsData.files.add(MapEntry('rewards[$i].image',
                MultipartFile.fromFileSync(event.images[i]!)));
          }

          var rewardsResponse = await dio.post(
              getApi(API.CREATE_REWARDS,
                  parameter: eventResponse.data.toString()),
              data: rewardsData);

          if (rewardsResponse.statusCode != 200) print('보상 생성 오류');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowQrcodeScreen(
                eventId: eventResponse.data.toString(),
              ),
            ),
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }
}
