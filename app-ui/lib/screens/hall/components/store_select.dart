import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreSelect extends StatefulWidget {
  final selectedStoreId;
  final storeList;
  const StoreSelect(
      {Key? key, required this.selectedStoreId, required this.storeList})
      : super(key: key);

  @override
  _StoreSelectState createState() => _StoreSelectState();
}

class _StoreSelectState extends State<StoreSelect> {
  late Future<String> storeLogo;

  @override
  void initState() {
    super.initState();
    storeLogo = _fetchStoreLogoData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: storeLogo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: kToolbarHeight * 0.6,
                width: kToolbarHeight * 0.6,
                decoration: BoxDecoration(
                    color: kShadowColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('$s3Url${snapshot.data}'),
                        fit: BoxFit.contain)));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Container(
              height: kToolbarHeight * 0.6,
              width: kToolbarHeight * 0.6,
              decoration: BoxDecoration(
                color: kShadowColor,
                shape: BoxShape.circle,
              ));
        });
  }

  Future<String> _fetchStoreLogoData() async {
    var dio = await authDio();

    final getStoreResponse = await dio
        .get(getApi(API.GET_STORE, suffix: '/${widget.selectedStoreId}'));

    final fetchedStoreLogo = getStoreResponse.data['logoImagePath'];

    return fetchedStoreLogo;
  }
}
