import 'dart:async';
import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginPage/LoginPageLogin.dart';

class CheckTimer extends GetxController{
  final time =false.obs;
  late Timer timer;

  void timerClear(){
    time.value = false;
  }

  void timerStart(){
    timer = Timer.periodic(const Duration(hours: 2,minutes: 58), (timer) {
      time.value= true;
    });
  }

  void stop(BuildContext context){
      timer.cancel();
      nickname = "null";
      showDialog(
          context: context,
          barrierDismissible:false,
          builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(5),
          content: Text("세션이 만료되어 로그인이 필요합니다.",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        );
      });
      Future.delayed(const Duration(milliseconds: 1000),()=>{
        Navigator.pop(context),
        Get.to(()=>const LoginPage(reLogin: true,))
      }
      );
  }
}