import 'package:flutter/material.dart';

import 'components/event_title.dart';
import 'components/event_reward.dart';
import 'components/event_hashtags.dart';
import 'components/event_period.dart';
import 'components/event_require.dart';
import 'components/event_template.dart';
import 'components/step_text.dart';
import 'components/step_progressbar.dart';
import 'components/step_help.dart';
import 'components/event_image.dart';

import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/period.dart';
import 'package:hashchecker/models/template.dart';

import '../event_preview/event_preview_screen.dart';

class CreateEventStepScreen extends StatefulWidget {
  const CreateEventStepScreen({Key? key}) : super(key: key);

  @override
  _CreateEventStepScreenState createState() => _CreateEventStepScreenState();
}

class _CreateEventStepScreenState extends State<CreateEventStepScreen> {
  int _step = 0;
  final maxStep = 7;

  // step 1: input event title
  late TextEditingController titleTextController;

  // step 2: select rewards
  List<Reward?> rewardList = [null];

  // step 3: input hashtags
  List<String> hashtagList = [];

  // step 4: set event period
  Period period = Period(DateTime.now(), DateTime.now(), true);

  // step 5: select images
  List<String> imageList = [];

  // step 6: select requirements
  int requireCnt = 10;
  List<String> requireList = [];
  List<bool> selectedRequireList = [];

  // step 7: select template
  Template template = Template(0);

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController();

    period = Period(DateTime.now(), DateTime.now(), true);

    for (int i = 0; i < requireCnt; i++) {
      requireList.add('#$i 세부 요청사항');
      selectedRequireList.add(false);
    }
  }

  @override
  void dispose() {
    titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(appBar: buildAppBar(), body: buildBody(context)),
      onWillPop: () async {
        bool result = _onBackPressed();
        return await Future.value(result);
      },
    );
  }

  bool _onBackPressed() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
    } else {
      Navigator.of(context).pop();
    }

    return false;
  }

  Column buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepProgressbar(context: context, step: _step, maxStep: maxStep),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildStepComponents()),
            SizedBox(height: 15),
            buildNextStepButton(context)
          ],
        ),
      ))
    ]);
  }

  Column buildStepComponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [StepText(step: _step), StepHelp(step: _step)]),
        SizedBox(height: 15),
        buildStepDetail(),
      ],
    );
  }

  Widget buildStepDetail() {
    switch (_step) {
      case 0:
        return EventTitle(controller: titleTextController);
      case 1:
        return EventReward(rewardList: rewardList);
      case 2:
        return EventHashtags(hashtagList: hashtagList);
      case 3:
        return EventPeriod(period: period);
      case 4:
        return EventImage(imageList: imageList);
      case 5:
        return EventRequire(
            requireList: requireList, selectedRequireList: selectedRequireList);
      case 6:
        return EventTemplate(selectedTemplate: template);
      default:
        return Container(child: Text('유효하지 않은 단계입니다.'));
    }
  }

  SizedBox buildNextStepButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        child: Text(
          _step == maxStep - 1 ? '이벤트 미리보기' : '다음 단계로',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          _onNextStepButtonPressed(context);
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigoAccent.shade700),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  void _showValidationErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _checkStepValidation(BuildContext context) {
    switch (_step) {
      case 0:
        if (titleTextController.value.text.isEmpty) {
          _showValidationErrorSnackBar(context, '이벤트 제목이 비어있어요!');
          return false;
        }
        break;
      case 1:
        if (rewardList.length == 1) {
          _showValidationErrorSnackBar(context, '이벤트 보상을 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
      case 2:
        if (hashtagList.isEmpty) {
          _showValidationErrorSnackBar(context, '필수 해시태그를 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
      case 3:
        if (!period.isPermanent &&
            period.startDate.isAfter(period.finishDate)) {
          _showValidationErrorSnackBar(context, '종료 날짜가 시작 날짜보다 앞서있어요!');
          return false;
        }
        break;
      case 4:
        if (imageList.isEmpty) {
          _showValidationErrorSnackBar(context, '이벤트 이미지를 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
    }

    return true;
  }

  void _onNextStepButtonPressed(BuildContext context) {
    if (!_checkStepValidation(context)) return;
    if (_step == maxStep - 1) {
      _createPreview(context);
    } else {
      setState(() {
        _step++;
      });
    }
  }

  void _createPreview(BuildContext context) {
    Event event = Event(
        title: titleTextController.value.text,
        rewardList: rewardList.sublist(0, rewardList.length - 1),
        hashtagList: hashtagList,
        period: period,
        images: imageList,
        requireList: selectedRequireList,
        template: template);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPreviewScreen(event: event),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_step > 0) {
                setState(() {
                  _step--;
                });
              } else {
                Navigator.of(context).pop();
              }
            }));
  }
}
