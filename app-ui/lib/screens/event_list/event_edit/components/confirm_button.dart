import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:intl/intl.dart';

class ConfirmButton extends StatelessWidget {
  final eventId;
  final event;
  final eventTitleController;
  final newImages;
  final deletedImagePaths;
  final newRewards;
  final deletedRewardIds;
  final startDatePickerController;
  final finishDatePickerController;
  const ConfirmButton(
      {Key? key,
      required this.eventId,
      required this.event,
      required this.eventTitleController,
      required this.newImages,
      required this.deletedImagePaths,
      required this.newRewards,
      required this.deletedRewardIds,
      required this.startDatePickerController,
      required this.finishDatePickerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 45,
      child: ElevatedButton(
        onPressed: () async {
          await _updateEvent();
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('이벤트 수정',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: Text("이벤트 수정이 완료되었습니다",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HallScreen()));
                        },
                        child: Text('확인', style: TextStyle(fontSize: 13)),
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all<Color>(kShadowColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kThemeColor)),
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))));
          Navigator.pop(context);
        },
        child: Text('이대로 수정하기',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  Future<void> _updateEvent() async {
    var dio = await authDio();

    dio.options.contentType = 'multipart/form-data';

    var eventData = FormData.fromMap({
      'title': eventTitleController.value.text.trim(),
      'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss')
          .format(startDatePickerController.selectedDate!),
      'finishDate': finishDatePickerController.selectedDate == null
          ? null
          : DateFormat('yyyy-MM-ddTHH:mm:ss')
              .format(finishDatePickerController.selectedDate!),
      if (newImages.length > 0)
        'newImages': List.generate(newImages.length,
            (index) => MultipartFile.fromFileSync(newImages[index])),
      if (deletedImagePaths.length > 0) 'deleteImagePaths': deletedImagePaths,
      'hashtags': event.hashtagList,
      'requirements': event.requireList,
      'template': event.template.id
    });

    final updateEventResponse = await dio
        .put(getApi(API.UPDATE_EVENT, suffix: '/$eventId'), data: eventData);

    print(updateEventResponse.data);
  }
}
