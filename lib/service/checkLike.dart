/*
import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';

import '../main.dart';
import '../model/Board.dart';
import 'package:http/http.dart' as http;

Future checkLike(BuildContext context, Board board) async {
  final userController = Get.put(UserController());

  if(checkTimerController.time.value){
    checkTimerController.stop(context);
  }else{
    if(!board.deleteTnF){
      Map<String, String> _queryParameters =  <String, String>{
        'postId': board.id,
      };
      final likeResponse = await http
          .get(Uri.http(serverIP, '/api/islike',_queryParameters),
          headers:{
            "Content-Type": "application/x-www-form-urlencoded",
            "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
          }
      );
      if(likeResponse.statusCode ==200) {
        board.fetchLike(likeResponse.body);
        //readPostController.setIsLike(likeResponse.body);
      }else{
        throw Exception("checkLike error");
      }
      var data = {
        "postId":board.id,
      };
      var body = json.encode(data);

      String work = "";

      if(board.like){
        work = "/deleteLike";
      }else{
        work = "/createLike";
      }

      setState((){
        board.setLike(board.like);
      });

      await http.post(
        Uri.http(serverIP, work),
        headers: {
          "Content-Type": "application/json",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );
    }
  }
}
*/
