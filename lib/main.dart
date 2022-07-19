import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

const String serverIP = "172.25.10.226:8080";
//const String serverIP = "172.30.1.18:8080";

void main() {
  KakaoSdk.init(nativeAppKey: 'cf0a2321116751cad7b6b470377c39b3');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   /* print(375/Get.width);*/
    return  GetMaterialApp(
      theme: ThemeData(
        canvasColor: Colors.black,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
          },
        ),
      ),
      title: 'Flutter Demo',
      home: const LoginPage(reLogin: false,),
    );
  }
}
