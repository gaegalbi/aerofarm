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
  //boardListController.boardClear(boardType);
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
        //"Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
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
        /*  boardListController.addBoard(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );*/
      }
    }
    if(boardListController.boardList.isEmpty){
      boardListController.none();
    }
  } else {
    throw Exception("searchFetch Error");
  }
}
/*

Future searchFetch(BoardType boardType,String search,String keyword) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.setUp();
  boardListController.boardClear(boardType);
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
        //"Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(boardType == BoardType.all || boardType==BoardType.hot){
      if(data['content'].length!=0) {
        for (int i = 0; i < data['content'].length; i++) {
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          Board board = Board.fetch(data['content'][i]);
          boardListController.addBoard(board);
          */
/*  boardListController.addBoard(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );*//*

        }
      }
    }
    else{
      int count=0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
          'searchCategory' : search,
          'keyword' : keyword
        };
        final response = await http
            .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              //"Cookie": "JSESSIONID=$session",
              //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
            }
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data['content'].length != 0) {
            for (int i = 0; i < data['content'].length; i++) {
              if (data['content'][i]['category'] == boardType.code) {
                boardListController.boardIdAdd(data['content'][i]['id']);
                boardListController.boardParentList.add(data['content'][i]['id']);
                Board board = Board.fetch(data['content'][i]);
                boardListController.addBoard(board);
                */
/*     boardListController.addBoard(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );*//*

                count++;
                //for문
                if(count==10){
                  break;
                }
              }
            }
            //while
            if(count==10){
              break;
            }
            //같은 카테고리 게시글이 없을때 다음 페이지로
            if (count >= 0) {
              pageIndexController.increment();
            }
          }else{
            break;
            //throw Exception("무한 루프 종료");
          }
        } else {
          throw Exception("각 게시판 받아오기 오류");
        }
      }
    }
*/
/*    if (boardListController.boardList.length == 1) {
      boardListController.addBoard(Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.345),
          alignment: Alignment.center,
          child: const Text(
            "게시글이 없습니다.",
            style: CommunityPageTheme.announce,
          )));
    }*//*

  } else {
    throw Exception("searchFetch Error");
  }
}*/
