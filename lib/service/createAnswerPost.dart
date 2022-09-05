import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../main.dart';
import '../model/Screen.dart';
import '../screen/CommunityScreen.dart';

createAnswerPost(BuildContext context,HtmlEditorController controller,TextEditingController titleController) async {
  final routeController = Get.put(RouteController());
  final userController = Get.put(UserController());

  if (controller.getText().toString().length == 1) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 900),
                  () {
                Navigator.pop(context);
              });
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(5),
            content: Text(
              "게시판 종류,제목,내용이\n있어야합니다.",
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          );
        });
  } else {
    //세션 만료 확인
    if(checkTimerController.time.value){
      checkTimerController.stop(context);
    }else{
      final txt = await controller.getText();
      var data = {
        "id":'',
        "category": routeController.board.value.category.code,
        "filter": routeController.board.value.filter.code,
        "title": titleController.text,
        "contents": txt,
        "postId": routeController.board.value.id,
      };
      var body = json.encode(data);
      await http.post(Uri.http(
          serverIP, '/createAnswerPost'),
        headers: {
          "Content-Type": "application/json",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
          //"Cookie": "JSESSIONID=$session",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );
      controller.editorController?.clearFocus();
      controller.disable();
      Future.delayed(const Duration(microseconds: 1), () {
        // Get.offAll(() => CommunityPageForm(category:widget.before));
        routeController.setCurrent(Screen.community);
        Get.offAll(() => CommunityScreen(boardType: routeController.beforeBoardType.value));
      });
    }
  }
}