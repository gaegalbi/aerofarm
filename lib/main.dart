import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

const String ipv4 = "172.25.4.179:8080";
//const String ipv4 = "172.30.1.34:8080"; //잡
//const String ipv4 = "172.30.1.51:8080"; //집

void main() {
  KakaoSdk.init(nativeAppKey: 'cf0a2321116751cad7b6b470377c39b3');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        canvasColor: Colors.black,
        brightness: Brightness.dark,
      ),
      title: 'Flutter Demo',
      home: const LoginPage(reLogin: false,),
    );
  }
}
