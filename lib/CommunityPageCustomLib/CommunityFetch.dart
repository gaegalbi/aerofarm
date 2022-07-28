import 'dart:convert';

import 'package:capstone/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';
import 'CommunityAddBoard.dart';
import 'CommunityAddComment.dart';
import 'CommunityNotice.dart';

final List<Map<String, dynamic>> customKeywords = [];
final Map<String, dynamic> postKeywords = {};
List<String> replyDetailList = [];

final dateInfoFormat = DateFormat('yyyy.MM.dd hh:mm');
/*final Map<String, String> matchCategory = {
  "all": "전체게시판",
  "hot": "인기게시판",
  "free": "자유게시판",
  "information": "정보게시판",
  "question": "질문게시판",
  "picture": "사진게시판",
  "trade": "거래게시판"
};*/

final Map<String, String> matchCategory = {
  "ALL": "전체게시판",
  "HOT": "인기게시판",
  "FREE": "자유게시판",
  "INFORMATION": "정보게시판",
  "QUESTION": "질문게시판",
  "PICTURE": "사진게시판",
  "TRADE": "거래게시판",
  "ANNOUNCEMENT":"공지사항"
};

List<String> boardCategory = [
  "free",
  "information",
  "question",
  "picture",
  "trade"
];

class PageIndexController extends GetxController{
  final pageIndex = 1.obs;

  void increment(){
    pageIndex.value++;
  }
  void decrement(){
    pageIndex.value--;
  }
  void setUp(){
    pageIndex.value = 1;
  }
}

class LoadingController extends GetxController{
  final loading = true.obs;

/*  void setStatus(){
    loading.toggle();
  }*/
  void setTrue(){
    loading.value = true;
  }
  void setFalse(){
    loading.value = false;
  }
}

class BeforeRouteController extends GetxController{
  final before = "".obs;
  static BeforeRouteController get to => Get.find();

  void setBefore(String route){
    before.value = route;
  }
}

class BoardListController extends GetxController{
  final boardList = <Widget>[].obs;
  final boardIdList = <int>[].obs;
  final boardParentList = <int>[].obs;

  //게시글
  void boardAdd(Widget widget){
    boardList.add(widget);
  }

  //답글
  void boardInsert(int index, Widget widget){
    boardList.insert(index, widget);
  }

  //답글
  void boardIdInsert(int index, int id){
    boardIdList.insert(index, id);
  }

  //중복방지
  void boardIdAdd(int id){
    boardIdList.add(id);
  }

  //중복방지
  void boardParentAdd(int index){
    boardParentList.add(index);
  }

  void boardIdClear(){
    boardIdList.clear();
    boardIdList.add(-1);
    boardParentList.clear();
  }

  void boardClear(){
    boardList.clear();
    boardList.add(notice());
  }
}
class CommentListController extends GetxController{
  final commentList= <Widget>[].obs;
  final commentGroupIdList = <int>[].obs;
  final commentIdList = <int>[].obs;
  final commentParentIdList = <int>[].obs;
  final commentPreventDuplicateIdList = <int>[].obs;
  final commentAnswerCount = 0.obs;

  void commentAdd(Widget widget){
    commentList.add(widget);
  }

  void commentInsert(int index,Widget widget){
    commentList.insert(index, widget);
  }

  void commentClear(){
    commentList.clear();
    commentParentIdList.clear();
    commentIdList.clear();
    commentGroupIdList.clear();
    commentPreventDuplicateIdList.clear();
    commentAnswerCount.value = 0;
  }
}

class SetCategoryController extends GetxController {
  final setCategory = "".obs;
  final List<bool> category = [true, false, false, false, false, false,].obs;

  void categoryClick(int index,String filter) {
    for (int i = 0; i < category.length; i++) {
      if (i != index) {
        category[i]= false;
      } else {
        category[i] = true;
      }
    }
    setCategory.value = filter;
  }
}
class ReadPostController extends GetxController{
  final isLike =false.obs;
  final content ="".obs;
  final id = "".obs;
  final writer = "".obs;
  final commentCount = "".obs;

  void setIsLike(String like){
    if(like == "true"){
      isLike.value = true;
    }else{
      isLike.value = false;
    }
  }

  void toggleLike(){
    isLike.value = !isLike.value;
  }

  void setContent(String html){
    content.value = html;
  }

  void setId(String inputId){
    id.value = inputId;
  }

  void setWriter(String inputId){
    writer.value = inputId;
  }

  void setCommentCount(String count){
    commentCount.value = count;
  }
}

class ReplyDetailListController extends GetxController{
  final replyDetail = {0:<Widget>[]}.obs;
  final replyDetailBefore = "".obs;
  final index = 0.obs;
  final keywords = Rx<Map<String, dynamic>>({});
  final before = "".obs;

  void replyDetailSetUp(){
    replyDetail.clear();
    replyDetailList.clear();
  }

  void replyDetailSetUpBefore(String inputBefore){
    replyDetailBefore.value = inputBefore;
  }

  void replyDetailSetUpBackRoute(int inputIndex, Map<String, dynamic> inputKeywords, String inputBefore){
    index.value = inputIndex;
    keywords.value = inputKeywords;
    before.value = inputBefore;
  }
}

Future activityPostStartFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

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
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if (postResponse.statusCode == 200) {
    data = jsonDecode(utf8.decode(postResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        boardListController.boardAdd(AddBoard(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity"));
      }
    }
  }
  else {
    throw Exception("activityPostStartFetch Error");
  }
}

Future activityLikedStartFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.setUp();
  boardListController.boardList.clear();
  boardListController.boardIdClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  Map<String, dynamic> data;
  final postResponse = await http
      .get(Uri.http(serverIP, '/api/my/likeposts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );

  if (postResponse.statusCode == 200) {
    data = jsonDecode(utf8.decode(postResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        boardListController.boardAdd(AddBoard(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity"));
      }
    }
  }
  else {
    throw Exception("activityLikedStartFetch Error");
  }
}

Future activityCommentStartFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final commentListController = Get.put(CommentListController());

  pageIndexController.setUp();
  commentListController.commentClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  Map<String, dynamic> data;
  final commentResponse = await http
      .get(Uri.http(serverIP, '/api/my/comments', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (commentResponse.statusCode == 200) {
    data = jsonDecode(utf8.decode(commentResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        commentListController.commentAdd(AddComment(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity", selectReply: '',));
      }
    }
  }
  else {
    throw Exception("activityCommentStartFetch Error");
  }
}

Future activityPostLoadFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.increment();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/my/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        boardListController.boardAdd(AddBoard(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity"));
      }
    }else{
      pageIndexController.decrement();
    }
  } else {
    throw Exception("activityPostLoadFetch Error");
  }
}

Future activityLikedLoadFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.increment();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/my/likeposts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        boardListController.boardAdd(AddBoard(
            index: pageIndexController.pageIndex.value,
            keywords: data['content'][i],
            before: "MyActivity"));
      }
    }else{
      pageIndexController.decrement();
    }
  } else {

    throw Exception("activityLikedLoadFetch Error");
  }
}

Future activityCommentLoadFetch() async {
  final pageIndexController = Get.put(PageIndexController());
  final commentListController = Get.put(CommentListController());

  pageIndexController.increment();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  Map<String, dynamic> data;
  final commentResponse = await http
      .get(Uri.http(serverIP, '/api/my/comments', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (commentResponse.statusCode == 200) {
    data = jsonDecode(utf8.decode(commentResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: "MyActivity", selectReply: '',));
      }
    }else{
      pageIndexController.decrement();
    }
  }
  else {

    throw Exception("activityCommentLoadFetch Error");
  }
}

Future searchFetch(String communityCategory,String search,String keyword) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.setUp();
  boardListController.boardClear();
  boardListController.boardIdClear();

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
    if(communityCategory=='ALL' || communityCategory =='HOT'){
      if(data['content'].length!=0) {
        for (int i = 0; i < data['content'].length; i++) {
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          boardListController.boardAdd(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );
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
              if (data['content'][i]['category'] == communityCategory) {
                boardListController.boardIdAdd(data['content'][i]['id']);
                boardListController.boardParentList.add(data['content'][i]['id']);
                boardListController.boardAdd(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );
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
      boardListController.boardAdd(Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.345),
          alignment: Alignment.center,
          child: const Text(
            "게시글이 없습니다.",
            style: CommunityPageTheme.announce,
          )));
    }
  } else {
    throw Exception("startFetch Error");
  }
}

//initState에서 해당 페이지 불러오기
Future startFetch(String communityCategory) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());

  pageIndexController.setUp();
  boardListController.boardClear();
  boardListController.boardIdClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
       /* "Content-Type": "application/json",*/
        //"Cookie": "JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    if(communityCategory=='ALL' || communityCategory =='HOT'){
      if(data['content'].length!=0) {
        for (int i = 0; i < data['content'].length; i++) {
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          boardListController.boardAdd(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );
        }
      }
    }
    else{
      int count=0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
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
              if (data['content'][i]['category'] == communityCategory) {
                boardListController.boardIdAdd(data['content'][i]['id']);
                boardListController.boardParentList.add(data['content'][i]['id']);
                boardListController.boardAdd(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );
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
      boardListController.boardAdd(Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.345),
          alignment: Alignment.center,
          child: const Text(
            "게시글이 없습니다.",
            style: CommunityPageTheme.announce,
          )));
    }
  } else {
    throw Exception("startFetch Error");
  }
}
//불러오기 (스크롤 내릴때)
Future loadFetch(String communityCategory) async{
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
    if (communityCategory == 'ALL' || communityCategory == 'HOT') {
      if (data['content'].length != 0) {
        for (int i = 0; i < data['content'].length; i++) {
          boardListController.boardIdAdd(data['content'][i]['id']);
          boardListController.boardParentList.add(data['content'][i]['id']);
          boardListController.boardAdd(AddBoard(
              index: pageIndexController.pageIndex.value,
              keywords: data['content'][i],
              before: communityCategory)
          );
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
              "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
            }
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data['content'].length != 0) {
            for (int i = 0; i < data['content'].length; i++) {
              if (data['content'][i]['category'] == communityCategory &&
                  !boardListController.boardIdList.contains(data['content'][i]['id'])) {
                boardListController.boardIdAdd(data['content'][i]['id']);
                boardListController.boardParentList.add(data['content'][i]['id']);
                boardListController.boardAdd(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: data['content'][i],
                    before: communityCategory)
                );
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
Future answerFetch(String communityCategory) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  //전체 게시판, 인기 게시판이 아닐때만 setUp (분류 게시판은 pageIndex가 무한루프를 돌아서 높음)
  if(communityCategory != 'ALL' && communityCategory !='HOT'){
    pageIndexController.setUp();
  }
  Map<int,dynamic> answer = {};

  int pageIndex = (pageIndexController.pageIndex.value-1) * 10;
  if(pageIndex>0){
    pageIndex--;
  }
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
      if(communityCategory != "ALL" && communityCategory!="HOT"){
        if(data[i]['category'] == communityCategory){
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
      for(int j=1;j<boardListController.boardList.length;j++){
        if(boardListController.boardIdList[j] == answer.keys.elementAt(i)){
          for(int k =0; k<answer[answer.keys.elementAt(i)].length;k++){
            if(!boardListController.boardIdList.contains(answer[answer.keys.elementAt(i)][k]['id'])){
               if(answer.keys.elementAt(i) == answerCheck[answerCheck.length-1] && answer.length != 1 && boardListController.boardParentList.last == answer[answer.keys.elementAt(i)][k]['parentId']){
                boardListController.boardAdd(AddBoard(index: pageIndexController.pageIndex.value, keywords: answer[answer.keys.elementAt(i)][k], before: communityCategory));
              }else{
                boardListController.boardInsert(
                    boardListController.boardIdList.indexOf(answer.keys.elementAt(i))+1 + k,
                    AddBoard(index: pageIndexController.pageIndex.value, keywords: answer[answer.keys.elementAt(i)][k], before: communityCategory));
              }
              boardListController.boardIdInsert(boardListController.boardIdList.indexOf(answer.keys.elementAt(i))+1 + k, answer[answer.keys.elementAt(i)][k]['id']);
            }
          }
        }
      }
    }
    } else {
      throw Exception("startAnswerFetch Error");
    }
}

Future categoryFetch(String communityCategory) async {
  final pageIndexController = Get.put(PageIndexController());
  final boardListController = Get.put(BoardListController());
  final setCategoryController  = Get.put(SetCategoryController());

  pageIndexController.setUp();
  boardListController.boardClear();
  boardListController.boardIdClear();
  int count;

    if(communityCategory=='ALL' || communityCategory =='HOT') {
      count=0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
        };
        final response = await http
            .get(Uri.http(serverIP, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              //"Cookie": "JSESSIONID=$session",
              //"Cookie": "remember-me=$rememberMe;JSESSIONID=$session",
            }
        );
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['content'].length != 0) {
          for (int i = 0; i < data['content'].length; i++) {

            if (setCategoryController.setCategory.value == "ALL") {
              boardListController.boardIdAdd(data['content'][i]['id']);
              boardListController.boardParentList.add(data['content'][i]['id']);
              boardListController.boardAdd(AddBoard(
                  index: pageIndexController.pageIndex.value,
                  keywords: data['content'][i],
                  before: communityCategory)
              );
              count++;
            } else {
              if (communityCategory == "HOT") {
                if (data['content'][i]['category'] == setCategoryController.setCategory.value) {
                  boardListController.boardIdAdd(data['content'][i]['id']);
                  boardListController.boardParentList.add(
                      data['content'][i]['id']);
                  boardListController.boardAdd(AddBoard(
                      index: pageIndexController.pageIndex.value,
                      keywords: data['content'][i],
                      before: communityCategory)
                  );
                  count++;
                }
              } else {
                if (data['content'][i]['filter'] ==
                    setCategoryController.setCategory.value) {
                  boardListController.boardIdAdd(data['content'][i]['id']);
                  boardListController.boardParentList.add(
                      data['content'][i]['id']);
                  boardListController.boardAdd(AddBoard(
                      index: pageIndexController.pageIndex.value,
                      keywords: data['content'][i],
                      before: communityCategory)
                  );
                  count++;
                }
              }
            }
            if(count==10){
              break;
            }
          }
        }
        if(count==10){
          break;
        }
      }
    }
    else{
      count=0;
      while (true) {
        Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
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
              if (data['content'][i]['category'] == communityCategory) {
                if(setCategoryController.setCategory.value == "ALL"){
                  boardListController.boardIdAdd(data['content'][i]['id']);
                  boardListController.boardParentList.add(data['content'][i]['id']);
                  boardListController.boardAdd(AddBoard(
                      index: pageIndexController.pageIndex.value,
                      keywords: data['content'][i],
                      before: communityCategory)
                  );
                  count++;
                }else{
                  if(setCategoryController.setCategory.value == data['content'][i]['filter']){
                    boardListController.boardIdAdd(data['content'][i]['id']);
                    boardListController.boardParentList.add(data['content'][i]['id']);
                    boardListController.boardAdd(AddBoard(
                        index: pageIndexController.pageIndex.value,
                        keywords: data['content'][i],
                        before: communityCategory)
                    );
                    count++;
                  }
                }
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
          }
        } else {
          throw Exception("각 게시판 받아오기 오류");
        }
      }
    }
    if (boardListController.boardList.length == 1) {
      boardListController.boardAdd(Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.345),
          alignment: Alignment.center,
          child: const Text(
            "게시글이 없습니다.",
            style: CommunityPageTheme.announce,
          )));
    }
  }

//readPost 게시글 내용 불러오기, 추천 유무
Future readPostContent(int postId, String communityCategory) async{
  final readPostController = Get.put(ReadPostController());

  customKeywords.clear();
  Map<String, String> _queryParameters =  <String, String>{
    'postId': postId.toString(),
  };
  final commentCountResponse = await http
      .get(Uri.http(serverIP, '/api/commentCount',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie":"JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      });
  readPostController.setCommentCount(commentCountResponse.body);

  final likeResponse = await http
      .get(Uri.http(serverIP, '/api/islike',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie":"JSESSIONID=$session",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if(likeResponse.statusCode ==200) {
    readPostController.setIsLike(likeResponse.body);
  }else{
    readPostController.setIsLike("false");
  }

  final postResponse = await http
      .get(Uri.http(serverIP, '/api/detail/post',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie":"JSESSIONID=$session",
        //"Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  if (postResponse.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(postResponse.bodyBytes));
    readPostController.setId(data['writer']);
    readPostController.setContent(data['contents']);
    readComment(postId, communityCategory,false);
  }else{
    throw Exception("readPostContent Error");
  }
}
Future readComment(int postId,String communityCategory,bool load) async{
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());

  if(load){
    pageIndexController.increment();
  }else {
    pageIndexController.setUp();
    commentListController.commentClear();
    replyDetailController.replyDetailSetUp();
  }
  int index = 0;

  final Map<String, String> _queryParameters = <String, String>{
    'postId': postId.toString(),
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
        data['content'][i].addAll({"category":communityCategory});
        commentListController.commentParentIdList.add(data['content'][i]['id']);
        commentListController.commentIdList.add(data['content'][i]['id']);
        answerCommentMap.addAll({data['content'][i]['id']:0});

        commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: communityCategory, selectReply: '',)
        );
        commentListController.commentGroupIdList.add(data['content'][i]['groupId']);

        replyDetailController.replyDetail[data['content'][i]['groupId']] = [];
        replyDetailController.replyDetail[data['content'][i]['groupId']]?.add(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: "ReadPost", selectReply: '',)
        );
      }

      if(answerCommentResponse.statusCode == 200){
        List<dynamic> data = jsonDecode(utf8.decode(answerCommentResponse.bodyBytes));

        //if(data.isNotEmpty) {
          for (int i = 0; i < data.length; i++) {
            data[i].addAll({"category":communityCategory});
            answerCommentMap.addAll({data[i]['id']:0});
            for(int j=0;j<commentListController.commentIdList.length;j++) {
              if (data[i]['parentId'] == commentListController.commentIdList[j] && !commentListController.commentIdList.contains(data[i]['id'])) {
                if (j == commentListController.commentList.length - 1) {
                  commentListController.commentIdList.add(data[i]['id']);
                  commentListController.commentList.add(AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                  answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
                } else {
                  commentListController.commentIdList.insert(j + 1 + answerCommentMap[data[i]['parentId']]!, data[i]['id']);
                  commentListController.commentList.insert(j + 1+ answerCommentMap[data[i]['parentId']]!, AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                  answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
                }
                replyDetailController.replyDetail[data[i]['groupId']]?.add(AddComment(
                  index: pageIndexController.pageIndex.value,
                  keywords: data[i],
                  before: "ReadPost", selectReply: '',));
              }
            }
          }
       // }
      }
    }
  }
  else{
    Exception("readComment Error");
  }
}

Future readReverseComment(int postId,String communityCategory,bool load) async{
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());

  if(load){
    pageIndexController.increment();
  }else {
    pageIndexController.setUp();
    commentListController.commentClear();
    replyDetailController.replyDetailSetUp();
  }
  int index = 0;

  final Map<String, String> _queryParameters = <String, String>{
    'postId': postId.toString(),
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
        data['content'][i].addAll({"category":communityCategory});
        commentListController.commentParentIdList.add(data['content'][i]['id']);
        commentListController.commentIdList.add(data['content'][i]['id']);
        answerCommentMap.addAll({data['content'][i]['id']:0});

        commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: communityCategory, selectReply: '',)
        );
        commentListController.commentGroupIdList.add(data['content'][i]['groupId']);

        replyDetailController.replyDetail[data['content'][i]['groupId']] = [];
        replyDetailController.replyDetail[data['content'][i]['groupId']]?.add(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: "ReadPost", selectReply: '',)
        );
      }

      if(answerCommentResponse.statusCode == 200){
        List<dynamic> data = jsonDecode(utf8.decode(answerCommentResponse.bodyBytes));

        for (int i = 0; i < data.length; i++) {
          data[i].addAll({"category":communityCategory});
          answerCommentMap.addAll({data[i]['id']:0});
          for(int j=0;j<commentListController.commentIdList.length;j++) {
            if (data[i]['parentId'] == commentListController.commentIdList[j] && !commentListController.commentIdList.contains(data[i]['id'])) {
              if (j == commentListController.commentList.length - 1) {
                commentListController.commentIdList.add(data[i]['id']);
                commentListController.commentList.add(AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              } else {
                commentListController.commentIdList.insert(j + 1 + answerCommentMap[data[i]['parentId']]!, data[i]['id']);
                commentListController.commentList.insert(j + 1+ answerCommentMap[data[i]['parentId']]!, AddComment(index: index, keywords: data[i], before: communityCategory, selectReply: ''));
                answerCommentMap[data[i]['parentId']] = answerCommentMap[data[i]['parentId']]!+1;
              }
              replyDetailController.replyDetail[data[i]['groupId']]?.add(AddComment(
                index: pageIndexController.pageIndex.value,
                keywords: data[i],
                before: "ReadPost", selectReply: '',));
            }
          }
        }
      }
    }
  }
  else{
    Exception("readComment Error");
  }
}
