import 'dart:convert';

import 'package:capstone/screen/CommunityReadPostScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Board.dart';
import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../service/fetch.dart' as fetch;

Future getActivityBoardFetch(String postId) async {
  final loadingController = Get.put(LoadingController());
  final floatingController = Get.put(FloatingController());
  final routeController = Get.put(RouteController());

  Map<String,String> _queryParameters = {
    'postId':postId
  };

  final response = await http
      .get(Uri.http(serverIP, '/api/community/oneposts',_queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if(response.statusCode==200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      Board board = Board.fetch(data);

      loadingController.setTrue();
      routeController.setCurrent(Screen.readPost);
      //readPostContent(board).then((value) => readComment(board.id, false)).then((value) => Get.to(() => CommunityReadPostScreen(board: board,)));
      floatingController.setUp();
      //modifySelectController.setBoard(board);
      fetch.readPostContent(board).then((value) => fetch.readComment(board.id, false)).then((value) =>  Navigator.of(loadingController.context).push(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board))));

      //.then((value) =>Navigator.of(loadingController.context).push(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board))));
  }else{
    throw Exception("activityBoardFetch Error");
  }

}