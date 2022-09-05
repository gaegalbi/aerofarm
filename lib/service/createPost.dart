import 'dart:convert';
import 'package:capstone/model/PostType.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../model/Screen.dart';
import '../screen/CommunityScreen.dart';

createPost(BuildContext context,Screen current,TextEditingController titleController,HtmlEditorController controller,) async {
  final postController = Get.put(PostController());
  final routeController = Get.put(RouteController());
  final userController = Get.put(UserController());

  if (postController.boardValue.value == BoardValue.undefined ||postController.filterValue.value == FilterValue.undefined ||
      titleController.text.isEmpty ||
      controller.getText().toString().length == 1) {
    /*_controller.document.toPlainText().length==1){*/
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
              "게시판 종류,분류,제목,내용이\n있어야합니다.",
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          );
        });
  } else {
    //세션 만료됬는지 확인
    if(checkTimerController.time.value){
      checkTimerController.stop(context);
    }else{
      final txt = await controller.getText();
      if(current==Screen.updatePost){
        var data = {
          "id":routeController.board.value.id,
          "category": postController.boardValue.value.code.toLowerCase(),
          "filter": postController.filterValue.value.code.toLowerCase(),
          "title": titleController.text,
          "contents": txt,
          "postId":'',
        };
        var body = json.encode(data);
        await http.post(
          Uri.http(serverIP, '/updatePost'),
          headers: {
            "Content-Type": "application/json",
            "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
            //"Cookie": "JSESSIONID=$session",
          },
          encoding: Encoding.getByName('utf-8'),
          body: body,
        );
      }else{
        //createBasicPost
        var data = {
          "id":'',
          "category": postController.boardValue.value.code.toLowerCase(),
          "filter": postController.filterValue.value.code.toLowerCase(),
          "title": titleController.text,
          "contents": txt,
          "postId":'',
        };
        var body = json.encode(data);

        await http.post(
          Uri.http(serverIP, '/createBasicPost'),
          headers: {
            "Content-Type": "application/json",
            "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
            //"Cookie": "JSESSIONID=${userController.user.value.session}",
          },
          encoding: Encoding.getByName('utf-8'),
          body: body,
        );
      }
      controller.editorController?.clearFocus();
      controller.disable();
      //Get.offAll(() => CommunityPageForm(category: widget.keywords['communityCategory']));
      Future.delayed(const Duration(microseconds: 1), () {
        //Get.offAll(() => CommunityPageForm(category:widget.before));
        routeController.setCurrent(Screen.community);
        print(routeController.beforeBoardType.value);
        Get.offAll(() => CommunityScreen(boardType: routeController.beforeBoardType.value));
      });
    }
  }
}