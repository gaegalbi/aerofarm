import 'dart:convert';
import 'package:get/get.dart';
import '../main.dart';
import '../model/Board.dart';
import '../model/BoardType.dart';
import '../provider/Controller.dart';
import 'package:http/http.dart' as http;

Future announcement() async {
  final boardListController = Get.put(BoardListController());
  final announceController = Get.put(AnnounceController());

  late Board board;

  Map<String, String> _queryParameters = <String, String>{
    'page': "1",
    'category':'announcement'
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      board = Board.fetch(data['content'][0]);
      announceController.setBoard(board);
      boardListController.boardIdAdd(int.parse(board.id));
    }else{
      announceController.setBoard(Board());
    }
  }
}

Future<void> startAnnouncementProcess() async {
  await startAnnouncementFetch();
  await answerAnnouncementFetch();
}

Future startAnnouncementFetch() async{
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  boardListController.boardClear(BoardType.announcement);
  pageIndexController.setUp();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
    'category':'announcement'
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  if(response.statusCode == 200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        boardListController.boardIdAdd(data['content'][i]['id']);
        boardListController.boardParentList.add(data['content'][i]['id']);
        Board board = Board.fetch(data['content'][i]);
        boardListController.addBoard(board);
      }
    }
    if (boardListController.boardList.isEmpty ) {
      boardListController.none();
    }
  }else{
    throw Exception("announcementStartFetch Error");
  }
}

Future answerAnnouncementFetch() async{
  final boardListController = Get.put(BoardListController());
  //전체 게시판, 인기 게시판이 아닐때만 setUp (분류 게시판은 pageIndex가 무한루프를 돌아서 높음)
  Map<int,dynamic> answer = {};

  final answerResponse = await http
      .get(Uri.http(serverIP, '/api/community/answerposts'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if (answerResponse.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(answerResponse.bodyBytes));
    for (int i = 0; i < data.length ; i++) {
      if(data[i]['category'] == BoardType.announcement.code){
        if(!answer.keys.contains(int.parse("${data[i]['parentId']}"))){
          answer[int.parse("${data[i]['parentId']}")] = [];
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);
        }else{
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);
        }
      }
      /*else{
        if(!answer.keys.contains(int.parse("${data[i]['parentId']}"))){
          answer[int.parse("${data[i]['parentId']}")] = [];
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);

        }else{
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);
        }
      }*/
    }
    var answerCheck= answer.keys.toList();
    //낮은 id가 가장 뒤에있음
    for(int i=0;i<answerCheck.length;i++){
      answerCheck.sort((a, b) => b.compareTo(a));
    }
    for(int i=0;i<answer.length;i++){
      for(int j=0;j<boardListController.boardIdList.length;j++){
        if(boardListController.boardIdList[j] == answer.keys.elementAt(i)){
          for(int k =0; k<answer[answer.keys.elementAt(i)].length;k++){
            Board board = Board.fetch(answer[answer.keys.elementAt(i)][k]);
            if(!boardListController.boardIdList.contains(answer[answer.keys.elementAt(i)][k]['id'])){
              if(answer.keys.elementAt(i) == answerCheck[answerCheck.length-1] && answer.isNotEmpty && boardListController.boardParentList.last == answer[answer.keys.elementAt(i)][k]['parentId']){
                boardListController.addBoard(board);
                boardListController.boardIdAdd(int.parse(board.id));
                // boardListController.addBoard(AddBoard(index: pageIndexController.pageIndex.value, keywords: answer[answer.keys.elementAt(i)][k], before: communityCategory));
              }else{
                boardListController.boardInsert(boardListController.boardIdList.indexOf(answer.keys.elementAt(i))+1 + k, board);
                boardListController.boardIdInsert(boardListController.boardIdList.indexOf(answer.keys.elementAt(i))+1 + k, answer[answer.keys.elementAt(i)][k]['id']);
              }
            }
          }
        }
      }
    }
  } else {
    throw Exception("startAnnouncementAnswerFetch Error");
  }
}
