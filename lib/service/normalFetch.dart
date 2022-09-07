import 'dart:convert';
import 'package:capstone/model/BoardType.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Board.dart';
import '../model/Comment.dart';
import '../provider/Controller.dart';
import '../widget/CommentWidget.dart';
import 'announceFetch.dart';

Future<void> startProcess(BoardType boardType, bool filter) async {
  await startFetch(boardType,filter);
  await answerFetch(boardType);
}

Future<void> loadProcess(BoardType boardType, bool filter) async {
  await loadFetch(boardType);
  await answerFetch(boardType);
}


Future startFetch(BoardType boardType,bool filter) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  final setCategoryController = Get.put(SetCategoryController());

  boardListController.boardClear(boardType);
  if(boardType != BoardType.announcement){
    announcement();
  }
  if(!filter){
    setCategoryController.setUp();
  }
  pageIndexController.setUp();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(boardType == BoardType.all || boardType==BoardType.hot){
      if(data['content'].length!=0) {
        for (int i = 0; i < data['content'].length; i++) {
          //공지사항 걸러내기
          if(data['content'][i]['category'] != BoardType.announcement.code) {
            //filter 처리
            if(filter){
              if(boardType == BoardType.all){
                if(setCategoryController.filterType.value.code == data['content'][i]['filter']){
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
      }
    } else{
      int count=0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
        };
        final response = await http
            .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            }
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data['content'].length != 0) {
            for (int i = 0; i < data['content'].length; i++) {
              if (data['content'][i]['category'] == boardType.code && data['content'][i]['category'] != BoardType.announcement.code ) {
                if(filter){
                    if(setCategoryController.filterType.value.code == data['content'][i]['filter']){
                      boardListController.boardIdAdd(data['content'][i]['id']);
                      boardListController.boardParentList.add(data['content'][i]['id']);
                      Board board = Board.fetch(data['content'][i]);
                      boardListController.addBoard(board);
                  }
                }else{
                  boardListController.boardIdAdd(data['content'][i]['id']);
                  boardListController.boardParentList.add(data['content'][i]['id']);
                  Board board = Board.fetch(data['content'][i]);
                  boardListController.addBoard(board);
                }
              /*  boardListController.addBoard(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );*/
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
    if (boardListController.boardList.length == 1) {
      boardListController.none();
    }
  } else {
    throw Exception("startFetch Error");
  }
}

//불러오기 (스크롤 내릴때)
Future loadFetch(BoardType boardType) async{
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.increment();

  final Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };

  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie":"JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if(response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(boardType == BoardType.all){
      if (data['content'].length != 0) {
        for (int i = 0; i < data['content'].length; i++) {
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          Board board = Board.fetch(data['content'][i]);
          boardListController.addBoard(board);
          /*      boardListController.addBoard(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );*/
        }
      } else {
        pageIndexController.decrement();
      }
    }
    else {
      pageIndexController.setUp();
      pageIndexController.increment();
      int count = 0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
        };
        final response = await http
            .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              //"Cookie": "JSESSIONID=$session",
             // "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
            }
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data['content'].length != 0) {
            for (int i = 0; i < data['content'].length; i++) {
              if (data['content'][i]['category'] == boardType.code &&
                  !boardListController.boardIdList.contains(data['content'][i]['id'])) {
                boardListController.boardIdAdd(data['content'][i]['id']);
                boardListController.boardParentList.add(data['content'][i]['id']);
                Board board = Board.fetch(data['content'][i]);
                boardListController.addBoard(board);
                /*      boardListController.addBoard(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );*/
                count++;
              }
            }
            //같은 카테고리 게시글이 없을때 다음 페이지로
            if (count >= 0) {
              pageIndexController.increment();
            }
          } else {
            break;
          }
        } else {
          throw Exception("각 게시판 받아오기 오류");
        }
      }
    }
  }
}

//답글 불러오기
Future answerFetch(BoardType boardType) async {
  final boardListController = Get.put(BoardListController());
  //전체 게시판, 인기 게시판이 아닐때만 setUp (분류 게시판은 pageIndex가 무한루프를 돌아서 높음)
/*  if(boardType == BoardType.all || boardType.displayName ==BoardType.hot.displayName){
    pageIndexController.setUp();
  }*/
  Map<int,dynamic> answer = {};
/*
  int pageIndex = (pageIndexController.pageIndex.value-1) * 10;
  if(pageIndex>0){
    pageIndex--;
  }*/

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
      if(boardType != BoardType.all && boardType!=BoardType.hot){
        if(data[i]['category'] == boardType.code){
          if(!answer.keys.contains(int.parse("${data[i]['parentId']}"))){
            answer[int.parse("${data[i]['parentId']}")] = [];
            answer[int.parse("${data[i]['parentId']}")].add(data[i]);
          }else{
            answer[int.parse("${data[i]['parentId']}")].add(data[i]);
          }
        }
      }else{
        if(!answer.keys.contains(int.parse("${data[i]['parentId']}"))){
          answer[int.parse("${data[i]['parentId']}")] = [];
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);

        }else{
          answer[int.parse("${data[i]['parentId']}")].add(data[i]);
        }
      }
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
            if(!boardListController.boardIdList.contains(answer[answer.keys.elementAt(i)][k]['id']) && board.category != BoardType.announcement){
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
    throw Exception("startAnswerFetch Error ${answerResponse.statusCode}");
  }
}

Future readPostContent(Board board) async{
  final userController = Get.put(UserController());
  final readPostController = Get.put(ReadPostController());
  final routeController = Get.put(RouteController());

  readPostController.setWriter(board.writer);

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
  }else{
    throw Exception("likeResponse error");
  }
  //조회수 증가를 위해 필요
  await http
      .get(Uri.http(serverIP, '/community/detail/${board.id}'),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  final boardResponse = await http
      .get(Uri.http(serverIP, '/api/community/oneposts',_queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  //print(Uri.http(serverIP, '/api/community/oneposts',_queryParameters));

  if(boardResponse.statusCode==200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(boardResponse.bodyBytes));
    //board = Board.fetch(data);
    board.commentCount = data['commentCount'];
    board.deleteTnF = data['deleteTnF'];
    board.likeCount = data['likeCount'];
    routeController.setCommentCount(board.commentCount);
  }

  final contentResponse = await http
      .get(Uri.http(serverIP, '/api/detail/post',_queryParameters),
      headers:{
        "Content-Type": "application/json",
      }
  );

  if(contentResponse.statusCode ==200) {
      //dom.Document document = parser.parse(contentResponse.body);
      //board.content = document.querySelector('.post-content')!.outerHtml;
      //여기서 댓글 수를 불러와야 좀더 깔끔할듯?
      var data =jsonDecode(utf8.decode(contentResponse.bodyBytes));
      board.content = data['contents'];
  }else{
    throw Exception("likeResponse error");
  }
}

Future readComment(String postId,bool load) async{
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());
  final loadingController = Get.put(LoadingController());

  if(load){
    pageIndexController.increment();
  }else {
    pageIndexController.setUp();
    commentListController.commentClear();
    replyDetailController.replyDetailSetUp();
  }

  final Map<String, String> _queryParameters = <String, String>{
    'postId': postId,
    'page':pageIndexController.pageIndex.value.toString()
  };

  final commentResponse = await http
      .get(Uri.http(serverIP, '/api/detail/comments',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  final answerCommentResponse = await http
      .get(Uri.http(serverIP, '/api/detail/answercomments',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  Map<int,int> answerCommentMap= {};

  if(commentResponse.statusCode == 200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(commentResponse.bodyBytes));
    if(data['content'].length!=0) {
      //부모 댓글을 그룹에 추가
      for (int i = 0; i < data['content'].length; i++) {
        //data['content'][i].addAll({"category":communityCategory});
        commentListController.commentParentIdList.add(data['content'][i]['id']);
        commentListController.commentIdList.add(data['content'][i]['id']);
        answerCommentMap.addAll({data['content'][i]['id']:0});
        Comment comment = Comment.fetch(data['content'][i]);
        commentListController.commentAdd(comment);

        commentListController.commentGroupIdList.add(data['content'][i]['groupId']);

        replyDetailController.replyDetail[data['content'][i]['groupId']] = [];
        replyDetailController.replyDetail[data['content'][i]['groupId']]?.add(CommentWidget(comment: comment,));
      }

      if(answerCommentResponse.statusCode == 200){
        List<dynamic> data = jsonDecode(utf8.decode(answerCommentResponse.bodyBytes));

        //if(data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          //data[i].addAll({"category":communityCategory});
          answerCommentMap.addAll({data[i]['id']:0});
          for(int j=0;j<commentListController.commentIdList.length;j++) {
            if (data[i]['parentId'] == commentListController.commentIdList[j] && !commentListController.commentIdList.contains(data[i]['id'])) {
              Comment comment = Comment.fetch(data[i]);
              if (j == commentListController.commentList.length - 1) {
                commentListController.commentIdList.add(data[i]['id']);
                commentListController.commentAdd(comment);
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              } else {
                commentListController.commentIdList.insert(j + 1 + answerCommentMap[data[i]['parentId']]!, data[i]['id']);
                commentListController.commentInsert(j + 1+ answerCommentMap[data[i]['parentId']]!, comment);
                //commentListController.commentList.insert(j + 1+ answerCommentMap[data[i]['parentId']]!, AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              }
              replyDetailController.replyDetail[data[i]['groupId']]?.add(CommentWidget(comment: comment,));
            }
          }
        }
        // }
      }
    }
    loadingController.setFalse();
  }
  else{
    Exception("readComment Error");
  }
}

Future readReverseComment(String postId,bool load) async{
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());
  final loadingController = Get.put(LoadingController());

  if(load){
    pageIndexController.increment();
  }else {
    pageIndexController.setUp();
    commentListController.commentClear();
    replyDetailController.replyDetailSetUp();
  }

  final Map<String, String> _queryParameters = <String, String>{
    'postId': postId,
    'page':pageIndexController.pageIndex.value.toString()
  };

  final commentResponse = await http
      .get(Uri.http(serverIP, '/api/detail/reversecomments',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  final answerCommentResponse = await http
      .get(Uri.http(serverIP, '/api/detail/answercomments',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
      }
  );

  Map<int,int> answerCommentMap= {};
  if(commentResponse.statusCode == 200){
    Map<String, dynamic> data = jsonDecode(utf8.decode(commentResponse.bodyBytes));
    if(data['content'].length!=0) {
      //부모 댓글을 그룹에 추가
      for (int i = 0; i < data['content'].length; i++) {
        //data['content'][i].addAll({"category":communityCategory});
        commentListController.commentParentIdList.add(data['content'][i]['id']);
        commentListController.commentIdList.add(data['content'][i]['id']);
        answerCommentMap.addAll({data['content'][i]['id']:0});
        Comment comment = Comment.fetch(data['content'][i]);
        commentListController.commentAdd(comment);

        commentListController.commentGroupIdList.add(data['content'][i]['groupId']);

        replyDetailController.replyDetail[data['content'][i]['groupId']] = [];
        replyDetailController.replyDetail[data['content'][i]['groupId']]?.add(CommentWidget(comment: comment,));
      }

      if(answerCommentResponse.statusCode == 200){
        List<dynamic> data = jsonDecode(utf8.decode(answerCommentResponse.bodyBytes));

        //if(data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          //data[i].addAll({"category":communityCategory});
          answerCommentMap.addAll({data[i]['id']:0});
          for(int j=0;j<commentListController.commentIdList.length;j++) {
            if (data[i]['parentId'] == commentListController.commentIdList[j] && !commentListController.commentIdList.contains(data[i]['id'])) {
              Comment comment = Comment.fetch(data[i]);
              if (j == commentListController.commentList.length - 1) {
                commentListController.commentIdList.add(data[i]['id']);
                commentListController.commentAdd(comment);
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              } else {
                commentListController.commentIdList.insert(j + 1 + answerCommentMap[data[i]['parentId']]!, data[i]['id']);
                commentListController.commentInsert(j + 1+ answerCommentMap[data[i]['parentId']]!, comment);
                //commentListController.commentList.insert(j + 1+ answerCommentMap[data[i]['parentId']]!, AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              }
              replyDetailController.replyDetail[data[i]['groupId']]?.add(CommentWidget(comment: comment,));
            }
          }
        }
        // }
      }
    }
    loadingController.setFalse();
  }
  else{
    Exception("readComment Error");
  }
}