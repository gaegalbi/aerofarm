import 'dart:convert';

import 'package:get/get.dart';

import '../main.dart';
import '../model/Board.dart';
import '../model/BoardType.dart';
import '../provider/Controller.dart';
import 'package:http/http.dart' as http;

import 'announceFetch.dart';


Future<void> startHotProcess(BoardType boardType, bool filter) async {
  await startHotFetch(boardType,filter);
}
Future startHotFetch(BoardType boardType,bool filter) async{
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  final setCategoryController = Get.put(SetCategoryController());

  boardListController.boardClear(boardType);
  announcement();
  pageIndexController.setUp();

  if(!filter){
    setCategoryController.setUp();
  }

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/community/hotposts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  if(response.statusCode == 200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        if(filter){
          //인기게시판은 카테고리
          if(boardType == BoardType.hot){
            if(setCategoryController.boardType.value.code == data['content'][i]['category']){
              boardListController.boardIdAdd(data['content'][i]['id']);
              boardListController.boardParentList.add(data['content'][i]['id']);
              Board board = Board.fetch(data['content'][i]);
              boardListController.addBoard(board);
            }
          }
        }else{
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          Board board = Board.fetch(data['content'][i]);
          boardListController.addBoard(board);
        }
      }
    }
    if (boardListController.boardList.length == 1 ) {
      boardListController.none();
    }
  }else{
    throw Exception("announcementStartFetch Error");
  }
}
