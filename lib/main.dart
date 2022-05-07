import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        canvasColor: Colors.black
      ),
      title: 'Flutter Demo',
      home: const LoginPage(),
    );
  }
}
