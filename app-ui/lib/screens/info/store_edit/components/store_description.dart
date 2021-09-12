import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';

class StoreDescription extends StatefulWidget {
  final Store store;
  const StoreDescription({Key? key, required this.store}) : super(key: key);

  @override
  _StoreDescriptionState createState() => _StoreDescriptionState();
}

class _StoreDescriptionState extends State<StoreDescription> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.store.description);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.description_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: TextField(
            maxLines: 4,
            minLines: 4,
            controller: _descriptionController,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor),
            cursorColor: kThemeColor,
            keyboardType: TextInputType.multiline,
            onChanged: (string) {
              widget.store.description = string;
            },
            decoration: InputDecoration(
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kThemeColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLiteFontColor, width: 1),
                ),
                contentPadding: const EdgeInsets.all(16),
                hintText: '가게에 대한 간단한 소개글을 입력해주세요',
                hintStyle: TextStyle(color: kLiteFontColor)),
            maxLength: 100,
          ),
        )
      ],
    );
  }
}
