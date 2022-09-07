import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Comment.dart';
import 'normalFetch.dart';

modifyComment(
    BuildContext context,
    ModifySelectController modifySelectController,
    Comment comment,
    TextEditingController textEditingController) async {
  final userController = Get.put(UserController());

  if (checkTimerController.time.value) {
    checkTimerController.stop(context);
  } else {
    if (modifySelectController.id.value != comment.id) {
      modifySelectController.setUpFalse();
    }
    modifySelectController.setId(comment.id);
    if (modifySelectController.modify.value &&
        textEditingController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 900), () {
              Navigator.pop(context);
            });
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
    } else {
      if (modifySelectController.modify.value) {
        var data = {
          "id": comment.id,
          "postId": comment.postId,
          "content": textEditingController.text,
          "commentId": comment.id
        };
        var body = json.encode(data);
        await http.post(
          Uri.http(serverIP, '/updateComment'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "JSESSIONID=${userController.user.value.session}",
          },
          encoding: Encoding.getByName('utf-8'),
          body: body,
        );
          readComment(comment.postId,false);
      } else {
        textEditingController.text = comment.content;
      }
    }
    modifySelectController.changeModify();
  }
}
