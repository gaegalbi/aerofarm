import 'dart:convert';
import 'package:capstone/MainPage/MainPageDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../themeData.dart';
import 'CommunityPageCreatePost.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;

import 'CommunityPageForm.dart';

class CommunityPageFloating extends StatelessWidget {
  final Map<String, dynamic> keywords;
  final String type;
  final String before;

  const CommunityPageFloating(
      {Key? key, required this.type, required this.keywords, required this.before,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nicknameController = Get.put(NicknameController());

    switch (type) {
      case "ReadPost":
        return SpeedDial(
            spaceBetweenChildren: 5,
            icon: Icons.menu,
            backgroundColor: MainColor.three,
            foregroundColor: Colors.white,
            children: [
              keywords['writer'] == nicknameController.nickname.value ? SpeedDialChild(
                child: const Text(
                  "삭제", style: CommunityPageTheme.floatingButton,),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                onTap: () async {
                  var body = json.encode({"id": keywords['id']});
                  await http.post(
                    Uri.http(ipv4, '/deletePost'),
                    headers: {
                      "Content-Type": "application/json",
                      "Cookie": "JSESSIONID=$session",
                    },
                    encoding: Encoding.getByName('utf-8'),
                    body: body,
                  );
                  Get.offAll(() => CommunityPageForm(category: before));
                },
              ) : SpeedDialChild(),
              keywords['writer'] ==  nicknameController.nickname.value ? SpeedDialChild(
                child: const Text(
                  "수정", style: CommunityPageTheme.floatingButton,),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                  Get.to(() => CommunityPageCreatePost(keywords: keywords,
                    type: "UpdatePost",
                    before: before,));
                },
              ) : SpeedDialChild(),
              SpeedDialChild(
                child: const Text(
                  "답글", style: CommunityPageTheme.floatingButton,),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                  Get.to(() => CommunityPageCreatePost(
                    keywords: keywords, type: type, before: before,));
                },
              ),
            ]
        );
      case "Profile":
        return Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: MainColor.three,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                checkTimerController.time.value ?
                checkTimerController.stop(context) :getProfile("MainPageMyProfile");
              },
              icon: const Text("수정", style: CommunityPageTheme.floatingButton,),)
        );
      case "CommunityProfile":
        return SpeedDial(
          spacing: 8,
            spaceBetweenChildren: 10,
            icon: Icons.menu,
            backgroundColor: MainColor.three,
            childrenButtonSize: const Size(150,50),
            foregroundColor: Colors.white,
            children: [
              SpeedDialChild(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: MainColor.three,
                  ),
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                      "내 정보 수정", style: CommunityPageTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :getProfile("CommunityPageEdit");
                },
              ),
              SpeedDialChild(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: MainColor.three,
                  ),
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "활동 보기", style: CommunityPageTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :getProfile("CommunityPageEdit");
                },
              ),
            ]
        );
      default :
        return Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: MainColor.three,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                checkTimerController.time.value ?
                checkTimerController.stop(context) :
                Get.to(() => CommunityPageCreatePost(
                  keywords: keywords, type: type, before: before,));
              },
              icon: Image.asset("assets/images/create.png")),
        );
    }
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';
import 'CommunityPageCreatePost.dart';

class CommunityPageFloating extends StatelessWidget {
  final Map<String,dynamic> keywords;
  final String type;
  final String before;

  const CommunityPageFloating(
      {Key? key, required this.type, required this.keywords, required this.before,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "ReadPost" ?
        Stack(
          children: [
            IconButton(
            onPressed: () {
              checkTimerController.time.value ?
              checkTimerController.stop(context) :
              Get.to(() => CommunityPageCreatePost(keywords:keywords, type: type,before: before,));
            },
            icon: const Text("답글"),
           ),]
        )
     :Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: MainColor.three,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            checkTimerController.time.value ?
            checkTimerController.stop(context) :
            Get.to(() => CommunityPageCreatePost(keywords:keywords, type: type,before: before,));
          },
          icon: Image.asset("assets/images/create.png")),
    );
  }
}*/
