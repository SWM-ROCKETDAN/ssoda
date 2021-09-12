import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/widgets/kpostal/kpostal.dart';

class StoreLocation extends StatefulWidget {
  final Store store;
  const StoreLocation({Key? key, required this.store}) : super(key: key);

  @override
  _StoreLocationState createState() => _StoreLocationState();
}

class _StoreLocationState extends State<StoreLocation> {
  late TextEditingController _zipCodeController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _zipCodeController =
        TextEditingController(text: widget.store.address.zipCode);
    _addressController =
        TextEditingController(text: widget.store.address.getFullAddress());
  }

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
                controller: _zipCodeController,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
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
                        widget.store.address = address;
                        setState(() {
                          _zipCodeController.text = address.zipCode;
                          _addressController.text = address.getFullAddress();
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text(
                '주소 검색',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.white24),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor)),
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
                controller: _addressController,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
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
