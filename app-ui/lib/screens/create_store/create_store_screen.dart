import 'package:flutter/material.dart';
import 'components/intro.dart';

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Intro(),
    );
  }
}
