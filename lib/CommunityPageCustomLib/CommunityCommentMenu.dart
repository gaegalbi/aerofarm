import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CommunityPage/CommunityPageReplyDetail.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../provider/Controller.dart';
import '../themeData.dart';
import 'CommunityAddComment.dart';
import 'CommunityFetch.dart';
import 'package:http/http.dart' as http;

class CommunityCommentMenu extends StatelessWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;
  const CommunityCommentMenu({Key? key, required this.index, required this.keywords, required this.before}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectController = Get.put(SelectReplyController());
    final modifyController = Get.put(ModifySelectController());
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child:TextButton(onPressed: (){
            selectController.setId(keywords['id']);
            Get.back();
            Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
          }, child: const Text("댓글 답글쓰기",style: CommunityScreenTheme.commentMenuButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
            color: MainColor.six,
          child:TextButton(onPressed: (){
            selectController.setId(keywords['id']);
            modifyController.setId(keywords['id']);
            modifyController.setUpTrue();
            Get.back();
            Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
          }, child: const Text("수정",style: CommunityScreenTheme.commentMenuButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child:TextButton(onPressed: () async {
            if(checkTimerController.time.value){
            checkTimerController.stop(context);
            }else {
              if (modifyController.modify.value &&
                  modifyController.id.value == keywords['id']) {
                modifyController.modify.value = false;
              } else {
                var body = json.encode({"id": keywords['id']});
                await http.post(Uri.http(serverIP, '/deleteComment'),
                    headers: {
                      "Content-Type": "application/json",
                      "Cookie": "JSESSIONID=$session",
                    },
                    body: body
                );
               // readComment(keywords['postId'], keywords['category'],false);
                Get.back();
              }
            }
          }, child: const Text("삭제",style: CommunityScreenTheme.commentMenuDeleteButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(onPressed: (){
              Get.back();
          }, child: const Text("취소",style: CommunityScreenTheme.commentMenuButton,)) ,
        )
      ],
    );
  }
}
