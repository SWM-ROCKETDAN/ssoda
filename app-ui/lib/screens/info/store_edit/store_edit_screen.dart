import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_category.dart';
import 'package:hashchecker/screens/create_store/components/store_logo.dart';
import 'package:image_picker/image_picker.dart';

import 'components/body.dart';
import 'components/store_description.dart';
import 'components/store_image.dart';
import 'components/store_location.dart';
import 'components/store_name.dart';

class StoreEditScreen extends StatefulWidget {
  const StoreEditScreen({Key? key}) : super(key: key);

  @override
  _StoreEditScreenState createState() => _StoreEditScreenState();
}

class _StoreEditScreenState extends State<StoreEditScreen> {
  late Future<Store> store;
  final List<String> newImages = [];
  final List<String> deletedImagePaths = [];

  @override
  void initState() {
    super.initState();
    store = _fetchStoreData();
  }

  Future<Store> _fetchStoreData() async {
    var dio = await authDio();

    final getUserStoresResponse = await dio.get(getApi(API.GET_USER_STORES));

    final storeId = getUserStoresResponse.data.last['id'];

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    final fetchedStore = getStoreResponse.data;

    return Store.fromJson(fetchedStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '가게 정보 수정',
            style: TextStyle(
                color: kDefaultFontColor, fontWeight: FontWeight.bold),
          )),
      body: FutureBuilder<Store>(
          future: store,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Body(
                  store: snapshot.data!,
                  newImages: newImages,
                  deletedImagePaths: deletedImagePaths);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return Center(child: const CircularProgressIndicator());
          }),
    );
  }
}
