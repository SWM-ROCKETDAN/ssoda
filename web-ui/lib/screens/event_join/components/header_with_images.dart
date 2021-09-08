import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';

class HeaderWithImages extends StatefulWidget {
  const HeaderWithImages({Key? key, required this.storeId, required this.event})
      : super(key: key);

  final storeId;
  final Event event;

  @override
  _HeaderWithImagesState createState() => _HeaderWithImagesState();
}

class _HeaderWithImagesState extends State<HeaderWithImages> {
  late Future<String> storeLogoPath;

  @override
  void initState() {
    super.initState();
    storeLogoPath = _fetchStoreLogoPathData();
  }

  Future<String> _fetchStoreLogoPathData() async {
    var dio = Dio();

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/${widget.storeId}'));

    final fetchedStore = getStoreResponse.data;

    final String fetchedStoreLogoPath = fetchedStore['logoImagePath'];

    return fetchedStoreLogoPath;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      child: Stack(children: [
        Container(
            color: kLiteFontColor,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: size.height * 0.4 - 15,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false),
              items: widget.event.images
                  .map((item) => Center(
                      child: Image.network('$s3Url$item',
                          fit: BoxFit.cover, height: size.height * 0.4 - 15)))
                  .toList(),
            )),
        Positioned(
            bottom: 14,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * 0.12 - 15,
              decoration: BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            )),
        Positioned(
            bottom: 0,
            right: size.width * 0.38,
            left: size.width * 0.38,
            child: FutureBuilder<String>(
                future: storeLogoPath,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        height: size.width * 0.24,
                        width: size.width * 0.24,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                  offset: Offset(0, -15),
                                  color: kDefaultFontColor.withOpacity(0.2))
                            ],
                            color: kShadowColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('$s3Url${snapshot.data}'),
                                fit: BoxFit.cover)));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Center(child: const CircularProgressIndicator());
                }))
      ]),
    );
  }
}
