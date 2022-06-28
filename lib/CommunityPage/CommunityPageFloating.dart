
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
    Material(
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
          icon: const Text("답글"),
    ),)
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
}