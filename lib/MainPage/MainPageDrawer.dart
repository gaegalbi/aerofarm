import 'dart:convert';
import 'package:capstone/CommunityPage/CommunityPageMyActivity.dart';
import 'package:capstone/screen/LoginScreen.dart';
import 'package:capstone/MachinePage/MachinePageList.dart';
import 'package:capstone/MainPage/MainPageMyProfile.dart';
import 'package:capstone/MainPage/MainPageMyProfileEdit.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../provider/Controller.dart';
import '../service/getRoute.dart';

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  double drawerPadding = MediaQuery.of(context).size.height*0.01;
  final nicknameController = Get.put(NicknameController());
  final tabController = Get.put(CustomTabController());

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
                  style: nicknameController.nickname.value.length >7 ?  MainScreenTheme.nameSub : MainScreenTheme.name,
                )),
                Container(
                    padding:  EdgeInsets.only(top: drawerPadding/2),
                    child: TextButton(
                        child: const Text("내 정보",
                            style: MainScreenTheme.modify),
                        onPressed: () async {
                         /* checkTimerController.time.value ?
                          checkTimerController.stop(context) : await getRoute("MainPage");*/
                        }
                        )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("소유한 기기 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                Get.to(()=>const MachinePageList());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 0;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityPostStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 댓글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 1;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityCommentStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("좋아요한 글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 2;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityCommentStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("구매내역 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("재배한 작물 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("로그아웃", style: MainScreenTheme.drawerButton),
              onPressed: () {
                if(isLogin) {
                  FlutterNaverLogin.logOutAndDeleteToken();
                }
                Get.offAll(()=>const LoginScreen(reLogin: false,));
              },
            ),
          )
        ],
      ),
    );
  }
}
