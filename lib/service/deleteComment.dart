import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Comment.dart';
import 'normalFetch.dart';

deleteComment(BuildContext context, ModifySelectController modifySelectController,Comment comment) async {
  final userController = Get.put(UserController());
  final routeController = Get.put(RouteController());

  if (checkTimerController.time.value) {
    checkTimerController.stop(context);
  } else {
    if (modifySelectController.id.value != comment.id) {
      modifySelectController.changeModify();
    }
    if (modifySelectController.modify.value &&
        modifySelectController.id.value == comment.id) {
      modifySelectController.modify.value = false;
    } else {
      var body = json.encode({"id": comment.id});
      await http.post(Uri.http(serverIP, '/deleteComment'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "JSESSIONID=${userController.user.value.session}",
          },
          body: body);
      //readPostContent(board);
      readComment(comment.postId,false);
      //startFetch(board.category);
      routeController.setCurrent(routeController.before.value);
      Get.back();
    }
  }
}


/*
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
}*/
