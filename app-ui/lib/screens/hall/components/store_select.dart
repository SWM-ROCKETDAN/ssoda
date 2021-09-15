import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store_list_item.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class StoreSelect extends StatefulWidget {
  final selectedStoreId;
  final List<StoreListItem> storeList;
  const StoreSelect({
    Key? key,
    required this.selectedStoreId,
    required this.storeList,
  }) : super(key: key);

  @override
  _StoreSelectState createState() => _StoreSelectState();
}

class _StoreSelectState extends State<StoreSelect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          _setSelectedStore(value as int);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HallScreen()));
        },
        icon: Container(
            height: kToolbarHeight * 0.6,
            width: kToolbarHeight * 0.6,
            decoration: BoxDecoration(
                color: kShadowColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        '$s3Url${widget.storeList[widget.storeList.indexWhere((element) => element.id == widget.selectedStoreId)].logo}'),
                    fit: BoxFit.contain))),
        itemBuilder: (context) => List.generate(
            widget.storeList.length,
            (index) => PopupMenuItem(
                value: widget.storeList[index].id,
                child: Row(
                  children: [
                    Container(
                        height: kToolbarHeight * 0.6,
                        width: kToolbarHeight * 0.6,
                        decoration: BoxDecoration(
                            color: kShadowColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$s3Url${widget.storeList[index].logo}'),
                                fit: BoxFit.contain))),
                    SizedBox(width: kDefaultPadding),
                    Text(widget.storeList[index].name)
                  ],
                ))));
  }

  Future<void> _setSelectedStore(int storeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('selectedStore', storeId);

    final newStoreId = context.read<SelectedStore>().id = storeId;
  }
}
