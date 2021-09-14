import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/screens/create_event/show_qrcode/show_qrcode_screen.dart';
import 'package:intl/intl.dart';

class CreateEventButton extends StatelessWidget {
  final Event event;
  const CreateEventButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(
          '이대로 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          var dio = await authDio();

          final storeId = await _getUserStoreId();

          dio.options.contentType = 'multipart/form-data';

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

          var eventResponse = await dio.post(
              getApi(API.CREATE_EVENT, suffix: '/$storeId'),
              data: eventData);

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
                MultipartFile.fromFileSync(event.rewardList[i]!.imgPath)));
          }

          var rewardsResponse = await dio.post(
              getApi(API.CREATE_REWARDS, suffix: '/${eventResponse.data}'),
              data: rewardsData);

          Navigator.push(
              context,
              slidePageRouting(ShowQrcodeScreen(
                eventId: eventResponse.data.toString(),
              )));
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  Future<String> _getUserStoreId() async {
    var dio = await authDio();

    dio.options.contentType = 'application/json';

    final response = await dio.get(getApi(API.GET_USER_STORES));

    return response.data.last['id'].toString();
  }
}
