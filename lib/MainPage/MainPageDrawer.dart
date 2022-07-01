import 'dart:convert';

import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:capstone/MachinePage/MachinePageList.dart';
import 'package:capstone/MainPage/MainPageMyProfile.dart';
import 'package:capstone/MainPage/MainPageMyProfileEdit.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';

Future<void> getProfile(String before) async {
  final response = await http.get(Uri.http(ipv4,
      '/api/my-page/info'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
      }
  );
  Map<String, dynamic> _user = jsonDecode(utf8.decode(response.bodyBytes));
  switch(before){
    case "MainPageMyProfile":
      Get.to(()=>MainPageMyProfileEdit(user:_user));
      break;
    case "MainPageMyProfileEdit":
      Get.back();
      //Get.off(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
    case "CommunityPage":
      Get.to(()=>MainPageMyProfile(user:_user, before: "CommunityPage",));
      break;
    case "CommunityPageEdit":
      Get.to(()=>MainPageMyProfileEdit(user:_user,));
      break;
    default:
      Get.to(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
  }
  /*before=="MainPageMyProfile" ? Get.to(()=>MainPageMyProfileEdit(user:_user)) : Get.to(()=> MainPageMyProfile(user:_user));*/
}

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  double drawerPadding = MediaQuery.of(context).size.height*0.012;
  final nicknameController = Get.put(NicknameController());

  return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
      color: MainColor.six,
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width*0.25,
            backgroundImage: profile?.image ?? const AssetImage("assets/images/profile.png"),
            /*backgroundImage: const AssetImage("assets/images/profile.png"),*/
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding*2),
            alignment: Alignment.center,
            child: Column(
              children: [
                 Obx(()=>Text(
                  nicknameController.nickname.value,
                  style: MainPageTheme.name,
                )),
                Container(
                    padding:  EdgeInsets.only(top: drawerPadding/2),
                    child: TextButton(
                        child: const Text("내 정보",
                            style: MainPageTheme.modify),
                        onPressed: () async {
                          checkTimerController.time.value ?
                          checkTimerController.stop(context) : await getProfile("MainPage");
                        }
                        )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("소유한 기기 조회", style: MainPageTheme.drawerButton),
              onPressed: () {
                Get.to(()=>const MachinePageList());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 글 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 댓글 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("기기 구매내역 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("재배한 작물 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("로그아웃", style: MainPageTheme.drawerButton),
              onPressed: () {
                if(isLogin) {
                  FlutterNaverLogin.logOutAndDeleteToken();
                }
                Get.offAll(()=>const LoginPage(reLogin: false,));
              },
            ),
          )
        ],
      ),
    );
  }
}
