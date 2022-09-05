import 'package:capstone/screen/MainScreen.dart';
import 'package:capstone/service/getProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import 'package:http/http.dart' as http;


import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../themeData.dart';

login(TextEditingController usernameController, TextEditingController passwordController,BuildContext context, bool reLogin) async {
  final nicknameController = Get.put(NicknameController());
  final routeController = Get.put(RouteController());
  try{
   /* final response = await http.get(
      Uri.http(serverIP, '/login'),// Uri.http('172.25.4.179:8080', '/login'),//Uri.http('127.0.0.1:8080', '/login')
    );
    tmp = response.headers['set-cookie'];

    session = tmp?.substring(tmp!.lastIndexOf('JSESSIONID')+11,tmp!.lastIndexOf('JSESSIONID')+43);
*/

    var data = {
      'email' :usernameController.text,
      'password' : passwordController.text,
      'remember-me' : "true"
    };

    final response1 = await http.post(
      Uri.http(serverIP, '/login'),//Uri.http('172.25.4.179:8080', '/login'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie":"JSESSIONID=$session",
      },
      //encoding: Encoding.getByName('utf-8'),
      body: data,
    );

    tmp = response1.headers['set-cookie'];

    session = tmp?.substring(tmp!.lastIndexOf('JSESSIONID')+11,tmp!.lastIndexOf('JSESSIONID')+43);

    print(usernameController.text);
    print(passwordController.text);
    print(data);

    if(response1.statusCode ==200){
      showDialog(context: context, barrierDismissible:false, builder: (context){
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(5),
          content: Text("이메일이나 비밀번호가 잘못되었습니다.\n또는 이메일 인증을 진행해야 합니다.",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        );
      });
      usernameController.text="";
      passwordController.text="";
      //팝업 띄우기
    }else{
      checkTimerController.timerClear();
      checkTimerController.timerStart();
      tmp = response1.headers['set-cookie'];
      session = tmp?.substring(tmp!.lastIndexOf('JSESSIONID')+11,tmp!.lastIndexOf('JSESSIONID')+43);
      rememberMe = tmp?.substring(tmp!.indexOf('remember-me')+12,tmp!.indexOf("; Max-Age"));

      getProfile(session!, rememberMe!);


      if(reLogin){
        Get.back();
      }else{
        routeController.setCurrent(Screen.main);
        Get.offAll(()=>const MainScreen());
      }
    }
  }catch(error){
    print(error);
  }
}