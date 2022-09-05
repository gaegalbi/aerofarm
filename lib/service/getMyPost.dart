import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/Board.dart';
import '../provider/Controller.dart';

Future getMyPostStart() async {
    final pageIndexController = Get.put(PageIndexController());
    final boardListController = Get.put(BoardListController());
    final userController = Get.put(UserController());
    final tabController = Get.put( CustomTabController());

    tabController.controller.index = 0;
    pageIndexController.setUp();
    boardListController.boardList.clear();
    boardListController.boardIdClear();

    Map<String, String> _queryParameters = <String, String>{
      'page': pageIndexController.pageIndex.value.toString(),
    };
    Map<String, dynamic> data;
    final postResponse = await http
        .get(Uri.http(serverIP, '/api/my/posts', _queryParameters),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          //"Cookie": "JSESSIONID=$session",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
        }
    );

    if (postResponse.statusCode == 200) {
      data = jsonDecode(utf8.decode(postResponse.bodyBytes));
      if(data['content'].length!=0) {
        for (int i = 0; i < data['content'].length; i++) {
          Board board = Board.fetch(data['content'][i]);
          boardListController.addBoard(board);
          boardListController.boardIdAdd(int.parse(board.id));
        }
      }
    }
    else {
      throw Exception("activityPostStartFetch Error");
    }
}

Future getMyPostLoad() async {

}

Future getMyLikePostStart() async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  final userController = Get.put(UserController());

  pageIndexController.setUp();
  boardListController.boardList.clear();
  boardListController.boardIdClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };

  final postResponse = await http
      .get(Uri.http(serverIP, '/api/my/likeposts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
      }
  );


  if (postResponse.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(postResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        Board board = Board.fetch(data['content'][i]);
        boardListController.addBoard(board);
        boardListController.boardIdAdd(int.parse(board.id));
        /*      boardListController.addBoard(AddBoard(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity"));*/
      }
    }else{
      boardListController.activityNone();
    }
  }
  else {
    throw Exception("likePost Error");
  }
}