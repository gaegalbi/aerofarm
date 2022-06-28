import 'dart:async';
import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckTimer extends GetxController{
  final time =(0.0).obs;
  late Timer timer;

  void timerClear(){
    time.value = 0.0;
  }

  void timerStart(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value++;
    });
  }
  bool checkTimer(){
    if(time.value>=10.0){
      return true;
    }else{
      return false;
    }
  }

  void stop(BuildContext context, bool need){
      timer.cancel();
      timerClear();
      showDialog(context: context, builder: (context){
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(5),
          content: Text("세션이 만료되어 로그인이 필요합니다.",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        );
      });
      if(!need){
        Future.delayed(const Duration(milliseconds: 1500),()=>
            Get.offAll(()=>const LoginPage(relogin: false,))
        );
      }else{
        Future.delayed(const Duration(milliseconds: 1500),()=>
            Get.to(()=>const LoginPage(relogin: true,))
        );
      }
  }
}