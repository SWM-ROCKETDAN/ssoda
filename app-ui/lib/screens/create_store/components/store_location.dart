import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/widgets/kpostal/kpostal.dart';

class StoreLocation extends StatelessWidget {
  final setAddress;
  final zipCodeController;
  final addressController;
  const StoreLocation(
      {Key? key,
      required this.setAddress,
      required this.zipCodeController,
      required this.addressController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kLiteFontColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: TextField(
                readOnly: true,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                controller: zipCodeController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '우편번호',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
            SizedBox(width: kDefaultPadding / 3),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      title: '주소 검색',
                      appBarColor: kScaffoldBackgroundColor,
                      titleColor: kDefaultFontColor,
                      loadingColor: kThemeColor,
                      callback: (Kpostal result) {
                        Address address = Address(
                            city: '${result.sido}시',
                            country: result.sigungu,
                            town: result.bname,
                            road: result.roadname,
                            building: result.address.split(' ').last,
                            zipCode: result.postCode,
                            latitude: result.latitude,
                            longitude: result.longitude);
                        setAddress(address);
                      },
                    ),
                  ),
                );
              },
              child: Text(
                '주소 검색',
                style: TextStyle(fontSize: 13),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kDefaultFontColor.withOpacity(0.85))),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kScaffoldBackgroundColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: TextField(
                readOnly: true,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                controller: addressController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '주소',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
