import 'package:flutter/material.dart';
import 'components/body.dart';

class RewardGetScreen extends StatefulWidget {
  const RewardGetScreen({Key? key}) : super(key: key);

  @override
  _RewardGetScreenState createState() => _RewardGetScreenState();
}

class _RewardGetScreenState extends State<RewardGetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Body(size: size));
  }
}
