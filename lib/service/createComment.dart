import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Board.dart';
import 'normalFetch.dart';

createComment(BuildContext context,TextEditingController textEditingController,Board board) async {
  final userController = Get.put(UserController());

  if (checkTimerController.time.value) {
    checkTimerController.stop(context);
  } else {
    if (textEditingController.text == "") {
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
      var data = {
        "postId": board.id,
        "content": textEditingController.text,
      };
      var body = json.encode(data);
      await http.post(
        Uri.http(serverIP, '/createComment'),
        headers: {
          "Content-Type": "application/json",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );
    }

    readPostContent(board);
    readComment(board.id, false);
    textEditingController.text = "";
  }
}
