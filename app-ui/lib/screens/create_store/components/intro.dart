import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';

class CreateStoreIntroScreen extends StatelessWidget {
  const CreateStoreIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/images/create_store/add_store.png'),
                          Text('가게 등록',
                              style: TextStyle(
                                  fontSize: 12.0, color: kLiteFontColor)),
                          SizedBox(height: kDefaultPadding / 2),
                          AutoSizeText('사장님 가게를 등록해볼까요?',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              minFontSize: 18),
                        ]),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(slidePageRouting(CreateStoreScreen()));
                      },
                      child: Text(
                        '우리가게 등록하기',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all<Color>(kShadowColor),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kThemeColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27.0)))),
                    ),
                  )
                ])));
  }
}
