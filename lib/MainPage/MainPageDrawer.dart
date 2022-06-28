import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:capstone/MachinePage/MachinePageList.dart';
import 'package:capstone/MainPage/MainPageMyProfile.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';

import '../LoginPage/LoginPageLogin.dart';

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double drawerPadding = MediaQuery.of(context).size.height*0.012;

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
                 Text(
                  nickname!,
                  style: MainTheme.name,
                ),
                Container(
                    padding:  EdgeInsets.only(top: drawerPadding/2),
                    child: TextButton(
                        child: const Text("내 정보 수정",
                            style: MainTheme.modify),
                        onPressed: () {
                          Get.off(()=>const MainPageMyProfile(),);
                        })),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("소유한 기기 조회", style: MainTheme.drawerButton),
              onPressed: () {
                Get.to(()=>const MachinePageList());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 글 조회", style: MainTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 댓글 조회", style: MainTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("기기 구매내역 조회", style: MainTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("재배한 작물 조회", style: MainTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("로그아웃", style: MainTheme.drawerButton),
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
