import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        resizeToAvoidBottomInset: false, //keyboard 올라와도 overflow 발생 x
        body: LoginPage(),
        backgroundColor: MainColor.ten,
      ),
    );
  }
}
