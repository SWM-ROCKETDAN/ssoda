import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/user.dart';
import 'package:hashchecker/screens/info/components/button_list.dart';
import 'package:hashchecker/screens/info/components/user_info.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<User> user;
  @override
  void initState() {
    super.initState();
    user = _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kScaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<User>(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return UserInfo(user: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Center(child: const CircularProgressIndicator());
              }),
          SizedBox(height: kDefaultPadding * 1.5),
          ButtonList(storeId: context.read<SelectedStore>().id)
        ],
      ),
    );
  }

  Future<User> _fetchUserData() async {
    var dio = await authDio();

    final getUserResponse = await dio.get(getApi(API.GET_USER_INFO));

    final User fetchedUser = User.fromJson(getUserResponse.data);

    return fetchedUser;
  }
}
