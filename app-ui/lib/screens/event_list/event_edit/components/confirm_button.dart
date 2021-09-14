import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/reward_edit_data.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmButton extends StatelessWidget {
  final eventId;
  final Event event;
  final eventTitleController;
  final newImages;
  final deletedImagePaths;
  final startDatePickerController;
  final finishDatePickerController;
  const ConfirmButton(
      {Key? key,
      required this.eventId,
      required this.event,
      required this.eventTitleController,
      required this.newImages,
      required this.deletedImagePaths,
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
          await _updateEvent(context);
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

  List<Reward?> _getNewRewards() {
    final List<Reward?> newRewards = event.rewardList
        .where((element) => element != null && element.id == null)
        .toList();
    return newRewards;
  }

  List<Reward?> _getUpdatedRewards(BuildContext context) {
    final List<int> updatedRewardIds =
        context.read<RewardEditData>().updatedRewardIds;

    final List<Reward?> updatedRewards = event.rewardList
        .where((element) =>
            element != null && updatedRewardIds.contains(element.id))
        .toList();

    return updatedRewards;
  }

  List<int> _getDeletedRewardIds(BuildContext context) {
    final List<int> deletedRewardIds =
        context.read<RewardEditData>().deletedRewardIds;

    return deletedRewardIds;
  }

  Future<void> _updateEvent(BuildContext context) async {
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

    List<Reward?> newRewards = _getNewRewards();
    List<Reward?> updatedRewards = _getUpdatedRewards(context);
    List<int> deletedRewardIds = _getDeletedRewardIds(context);

    if (newRewards.length > 0) {
      var newRewardsData = FormData();

      for (int i = 0; i < newRewards.length; i++) {
        if (newRewards[i] == null) continue;
        newRewardsData.fields
            .add(MapEntry('rewards[$i].name', newRewards[i]!.name));
        print(newRewards[i]!.name);
        newRewardsData.fields.add(
            MapEntry('rewards[$i].level', newRewards[i]!.level.toString()));
        print(newRewards[i]!.level);
        newRewardsData.fields.add(
            MapEntry('rewards[$i].price', newRewards[i]!.price.toString()));
        print(newRewards[i]!.price);
        newRewardsData.fields.add(
            MapEntry('rewards[$i].count', newRewards[i]!.count.toString()));
        print(newRewards[i]!.count);
        newRewardsData.fields.add(MapEntry(
            'rewards[$i].category', newRewards[i]!.category.index.toString()));
        print(newRewards[i]!.category);

        newRewardsData.files.add(MapEntry(
            'rewards[$i].image',
            MultipartFile.fromFileSync(
                newRewards[i]!.imgPath.substring(kNewImagePrefix.length))));
        print(newRewards[i]!.imgPath);
      }

      var createNewRewardResponse =
          await dio.post(getApi(API.CREATE_REWARDS, suffix: '/$eventId'));

      print('save new rewards: ${createNewRewardResponse.data}');
    }

    if (updatedRewards.length > 0) {
      var updatedRewardsData = FormData();

      for (int i = 0; i < updatedRewards.length; i++) {
        if (updatedRewards[i] == null) continue;
        updatedRewardsData.fields
            .add(MapEntry('rewards[$i].id', updatedRewards[i]!.id.toString()));
        print(updatedRewards[i]!.id);
        updatedRewardsData.fields
            .add(MapEntry('rewards[$i].name', updatedRewards[i]!.name));
        print(updatedRewards[i]!.name);
        updatedRewardsData.fields.add(
            MapEntry('rewards[$i].level', updatedRewards[i]!.level.toString()));
        print(updatedRewards[i]!.level);

        updatedRewardsData.fields.add(
            MapEntry('rewards[$i].price', updatedRewards[i]!.price.toString()));
        print(updatedRewards[i]!.price);

        updatedRewardsData.fields.add(
            MapEntry('rewards[$i].count', updatedRewards[i]!.count.toString()));
        print(updatedRewards[i]!.count);

        updatedRewardsData.fields.add(MapEntry('rewards[$i].category',
            updatedRewards[i]!.category.index.toString()));
        print(updatedRewards[i]!.category);

        if (updatedRewards[i]!.imgPath.startsWith(kNewImagePrefix))
          updatedRewardsData.files.add(MapEntry(
              'rewards[$i].image',
              MultipartFile.fromFileSync(updatedRewards[i]!
                  .imgPath
                  .substring(kNewImagePrefix.length))));
        print(updatedRewards[i]!.imgPath);
      }

      final updateRewardsResponse =
          await dio.put(getApi(API.UPDATE_REWARDS), data: updatedRewardsData);

      print('update new rewards: ${updateRewardsResponse.data}');
    }

    if (deletedRewardIds.length > 0) {
      dio.options.contentType = 'application/json';

      final deleteRewardsResponse = await dio.delete(getApi(API.DELETE_REWARDS),
          data: {'rewardIds': deletedRewardIds});

      print('delete rewards: ${deleteRewardsResponse.data}');
    }
  }
}
