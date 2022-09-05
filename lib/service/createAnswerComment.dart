import 'dart:convert';

import 'package:capstone/service/fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../model/Board.dart';
import '../model/Comment.dart';
import '../model/Screen.dart';
import '../provider/Controller.dart';
import 'package:http/http.dart' as http;

import '../screen/CommunityReplyScreen.dart';

createAnswerComment(BuildContext context,TextEditingController textEditingController,Comment comment,Board board ) async {
  final userController = Get.put(UserController());
  final routeController = Get.put(RouteController());

  if(checkTimerController.time.value){
    checkTimerController.stop(context);
  }else{
    if(textEditingController.text==""){
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 900), () {Navigator.pop(context);});
            return const AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.all(5),
              content: Text(
                "댓글 내용이\n있어야합니다.",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            );
          });
    }else{
      var data = {
        "id":comment.id,
        "postId": comment.postId,
        "content": textEditingController.text,
        "commentId" : comment.id
      };
      var body = json.encode(data);
      await http.post(
        Uri.http(serverIP, '/createAnswerComment'),
        headers: {
          "Content-Type": "application/json",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );
      //readPostContent(widget.keywords['postId'], widget.keywords['category']);
      readPostContent(board);
      readComment(comment.postId, false);

      textEditingController.text = "";
      routeController.current.value == Screen.readPost ?
          Get.off(()=>CommunityReplyScreen(board: board,))
          : Get.back();
    /*  replyDetailController.replyDetailBefore =="ReadPost" ?
      Get.off(()=>CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before))
          : Get.back();*/
    }
  }
}
