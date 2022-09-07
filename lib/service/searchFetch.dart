import 'dart:convert';
import 'package:capstone/model/BoardType.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/Board.dart';
import '../provider/Controller.dart';


Future searchStartFetch(String search,String keyword,BoardType boardType) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  final postController = Get.put(PostController());

  pageIndexController.setUp();
  boardListController.boardIdList.clear();
  boardListController.boardList.clear();
  boardListController.boardIdClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
    'searchCategory' : search,
    'keyword' : keyword
  };

  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/json",
      }
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        if(postController.boardValue.value == BoardType.all){
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          Board board = Board.fetch(data['content'][i]);
          boardListController.addBoard(board);
        }else{
          if(postController.boardValue.value.code == data['content'][i]['category']){
            boardListController.boardIdAdd(data['content'][i]['id']);
            boardListController.boardParentList.add(data['content'][i]['id']);
            Board board = Board.fetch(data['content'][i]);
            boardListController.addBoard(board);
          }
        }
      }
    }
    if(boardListController.boardList.isEmpty){
      boardListController.none();
    }
  } else {
    throw Exception("searchFetch Error");
  }
}