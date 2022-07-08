import 'dart:convert';

import 'package:capstone/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';
import 'CommunityAddBoard.dart';
import 'CommunityAddComment.dart';
import 'CommunityNotice.dart';

//final List<Widget> boardList = [];
final List<Map<String, dynamic>> keywords = [];
final List<Map<String, dynamic>> customKeywords = []; //post-data
final List<Map<String, dynamic>> answerKeywords = []; //answer-data
final Map<String, dynamic> postKeywords = {};
List<String> replyDetailList = [];
final dateFormat = DateFormat('yyyy.MM.dd');
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
  "TRADE": "거래게시판"
};

List<String> boardCategory = [
  "free",
  "information",
  "question",
  "picture",
  "trade"
];


class CategoryIndexController extends GetxController{
  final categoryIndex = 0.obs;
  void increment(){
    categoryIndex.value++;
  }
  void setUp(){
    categoryIndex.value = 0;
  }
}


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
  void boardIdAdd(int index){
    boardIdList.add(index);
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

  void commentAdd(Widget widget){
    commentList.add(widget);
  }

  void commentClear(){
    commentList.clear();
  }
}

class SetCategoryController extends GetxController {
  final setCategory = "ALL".obs;
  final List<bool> category = [true, false, false, false, false, false,].obs;

  void categoryClick(int index) {
    for (int i = 0; i < category.length; i++) {
      if (i != index) {
        category[i]= false;
      } else {
        category[i] = true;
        switch (i) {
          case 1:
            setCategory.value = "FREE";
            break;
          case 2:
            setCategory.value = "PICTURE";
            break;
          case 3:
            setCategory.value = "INFORMATION";
            break;
          case 4:
            setCategory.value = "QUESTION";
            break;
          case 5:
            setCategory.value = "TRADE";
            break;
          default:
            setCategory.value = "ALL";
            break;
        }
      }
    }
  }
}
class ReadPostController extends GetxController{
  final isLike =false.obs;
  final content ="".obs;
  final id = "".obs;

  void setIsLike(String like){
    if(like == "1"){
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
      .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
      }
  );
  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
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
            .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Cookie": "JSESSIONID=$session",
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
      .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
      }
  );
  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
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
            .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Cookie": "JSESSIONID=$session",
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
      .get(Uri.http(ipv4, '/api/community/posts',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie":"JSESSIONID=$session",
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
            .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Cookie": "JSESSIONID=$session",
            }
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(
              utf8.decode(response.bodyBytes));
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
      .get(Uri.http(ipv4, '/api/community/answerPosts'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
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

  pageIndexController.setUp();
  boardListController.boardClear();
  boardListController.boardIdClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
      }
  );
  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
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
            .get(Uri.http(ipv4, '/api/community/posts', _queryParameters),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Cookie": "JSESSIONID=$session",
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

class ReplyDetailListController extends GetxController{
  final replyDetail = {"-1":<Widget>[]}.obs;
  late String before;

  void replyDetailFirstAdd(String element){
      replyDetail[element]=[];
  }

  void replyDetailAdd(String element,Widget widget){
    replyDetail[element]!.add(widget);
  }

  void replyDetailSetUp(){
    replyDetail.clear();
    replyDetailList.clear();
  }

  void replyDetailSetUpBefore(String inputBefore){
    before = inputBefore;
  }

}

//readPost 게시글 내용 불러오기, 추천 유무
Future readPostContent(int postId, String communityCategory) async{
  final readPostController = Get.put(ReadPostController());
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());

  customKeywords.clear();
  commentListController.commentClear();
  final response = await http
      .get(Uri.http(ipv4, '/community/detail/$postId'),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie":"JSESSIONID=$session",
      }
  );
  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);
    readPostController.setContent(document.querySelector('.post-content')!.outerHtml);
    readPostController.setIsLike(document.querySelector('.isSelected')!.text);
    List<dom.Element> keywordElements = document.querySelectorAll('.comment-info');
    List<dom.Element> answerKeywordElements = document.querySelectorAll('.answer-comment-info');
    for (var element in keywordElements) {
      dom.Element? commentWriter = element.querySelector('.comment-writer');
      dom.Element? commentContent = element.querySelector('.comment-content');
      dom.Element? commentDate = element.querySelector('.comment-date');
      dom.Element? commentDelete = element.querySelector('.comment-delete');
      dom.Element? commentId = element.querySelector('.comment-id');
      dom.Element? commentGroupId = element.querySelector('.comment-group-id');
      customKeywords.add({
        'writer': commentWriter?.text,
        'date': commentDate?.text,
        'content':  commentContent?.text,
        'category' : communityCategory,
        'id' : postId,
        "delete" : commentDelete?.text,
        "commentId" : commentId?.text,
        "commentGroupId" : commentGroupId?.text,
      });
    }
    for (var element in answerKeywordElements) {
      dom.Element? commentWriter = element.querySelector('.answer-comment-writer');
      dom.Element? commentContent = element.querySelector('.answer-comment-content');
      dom.Element? commentDate = element.querySelector('.answer-comment-date');
      dom.Element? commentDelete = element.querySelector('.answer-comment-delete');
      dom.Element? commentId = element.querySelector('.answer-comment-id');
      dom.Element? commentGroupId = element.querySelector('.answer-comment-group-id');
      answerKeywords.add({
        'writer': commentWriter?.text,
        'date': commentDate?.text,
        'content':  commentContent?.text,
        'category' : communityCategory,
        'id' : postId,
        "delete" : commentDelete?.text,
        "commentId" : commentId?.text,
        "commentGroupId" : commentGroupId?.text,
      });
    }
    for (var element in customKeywords) {
      if(!replyDetailController.replyDetail.keys.contains(element['commentGroupId']) && !replyDetailList.contains(element['commentId'])
      ){
        //replyDetail[element['commentGroupId']] = [];
        replyDetailController.replyDetailFirstAdd(element['commentGroupId']);
     /*   replyDetail[element['commentGroupId']]!.add(AddComment(
          index: pageIndexController.pageIndex.value ,keywords: element, before: "ReadPost", selectReply: '',//beforeRouteController.before.value,
        ));*/
        replyDetailController.replyDetailAdd(element['commentGroupId'], AddComment(
          index: pageIndexController.pageIndex.value ,keywords: element, before: "ReadPost", selectReply: '',//beforeRouteController.before.value,
        ));
        replyDetailList.add(element['commentId']);
      }
      commentListController.commentAdd(AddComment(
        index: pageIndexController.pageIndex.value ,keywords: element, before: communityCategory, selectReply: '',//beforeRouteController.before.value,
      ));
      for(var answerElement in answerKeywords){
        if(answerElement['commentGroupId'] == element['commentGroupId']){
          //if(replyDetail[element['commentGroupId']].)
          if(!replyDetailList.contains(answerElement['commentId'])){
           /* replyDetail[element['commentGroupId']]!.add(AddComment(
              index: pageIndexController.pageIndex.value ,keywords: answerElement, before: "ReadPost", selectReply: '',//beforeRouteController.before.value,
            ));*/
            replyDetailController.replyDetailAdd(element['commentGroupId'], AddComment(
              index: pageIndexController.pageIndex.value ,keywords: answerElement, before: "ReadPost", selectReply: '',//beforeRouteController.before.value,
            ));
          }
          commentListController.commentAdd(AddComment(
            index: pageIndexController.pageIndex.value ,keywords: answerElement, before: communityCategory, selectReply: '',//beforeRouteController.before.value,
          ));
        }
      }
    }
    answerKeywords.clear();

  }else{
    throw Exception("readPostContent Error");
  }
}

//readPost내에서 불러오기
Future loadReadPostContent(int postId, String communityCategory) async{
  final readPostController = Get.put(ReadPostController());
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());

  customKeywords.clear();

  final Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  final response = await http
      .get(Uri.http(ipv4, '/community/detail/$postId',_queryParameters),
      headers:{
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie":"JSESSIONID=$session",
      }
  );
  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);
    readPostController.setContent(document.querySelector('.post-content')!.outerHtml);
    readPostController.setIsLike(document.querySelector('.isSelected')!.text);
    List<dom.Element> keywordElements = document.querySelectorAll('.comment-info');
    if(keywordElements.isEmpty){
      pageIndexController.decrement();
    }
    for (var element in keywordElements) {
      dom.Element? commentWriter = element.querySelector('.comment-writer');
      dom.Element? commentContent = element.querySelector('.comment-content');
      dom.Element? commentDate = element.querySelector('.comment-date');
      customKeywords.add({
        'writer': commentWriter?.text,
        'date': commentDate?.text,
        'content':  commentContent?.text,
        'category' : communityCategory,
        'id' : postId
      });
    }
    for (var element in customKeywords) {
      commentListController.commentAdd(AddComment(
        index: pageIndexController.pageIndex.value ,keywords: element, before: communityCategory, selectReply: '',//beforeRouteController.before.value,
      ));
    }
  }else{
    throw Exception("loadReadPostContent Error");
  }
}

Future fetch(String communityCategory, bool readPost) async {
  String current = dateFormat.format(DateTime.now());
  final categoryIndexController = Get.put(CategoryIndexController());
  final pageIndexController = Get.put(PageIndexController());
  final loadingController = Get.put(LoadingController());
  final boardListController = Get.put(BoardListController());
  final commentListController = Get.put(CommentListController());
  final setCategoryController = Get.put(SetCategoryController());
  final readPostController = Get.put(ReadPostController());

  if(readPost){
    customKeywords.clear();
    final Map<String, String> _queryParameters = <String, String>{
      'page': pageIndexController.pageIndex.value.toString(),
    };
    final response = await http
        .get(Uri.http(ipv4, '/community/detail/${readPostController.id.value}',_queryParameters),
        headers:{
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie":"JSESSIONID=$session",
        }
    );
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      List<dom.Element> keywordElements = document.querySelectorAll('.comment-info');
      readPostController.setContent(document.querySelector('.post-content')!.outerHtml);
      readPostController.setIsLike(document.querySelector('.isSelected')!.text);
      for (var element in keywordElements) {
        dom.Element? commentWriter = element.querySelector('.comment-writer');
        dom.Element? commentContent = element.querySelector('.comment-content');
        dom.Element? commentDate = element.querySelector('.comment-date');
        customKeywords.add({
          'writer': commentWriter?.text,
          'date': commentDate?.text,
          'content':  commentContent?.text,
          'category' : communityCategory,
          'id' : readPostController.id.value
        });
      }
      //commentListController.commentClear();
      for (var element in customKeywords) {
        commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value ,keywords: element, before: communityCategory, selectReply: '',//beforeRouteController.before.value,
        ));
      }
    }else{
      throw Exception('Failed to load post');
    }
  }else{
    boardListController.boardList.clear();
    if (communityCategory== 'ALL' || communityCategory == 'HOT') {
      customKeywords.clear();
      postKeywords.clear();
      if (setCategoryController.setCategory.value!="ALL") {
        boardListController.boardClear();
        pageIndexController.setUp();
        while (true) {
          final Map<String, String> _queryParameters = <String, String>{
            'page': pageIndexController.pageIndex.value.toString(),
          };
          final response = await http.get(Uri.http(
              ipv4, '/community/${setCategoryController.setCategory.value}', _queryParameters));
          if (response.statusCode == 200) {
            dom.Document document = parser.parse(response.body);
            List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
            if (keywordElements.isEmpty) {
              break;
            } else {
              for (var element in keywordElements) {
                dom.Element? writer = element.querySelector('.post-writer');
                dom.Element? title = element.querySelector('.post-title');
                dom.Element? category = element.querySelector('.post-category');
                dom.Element? date = element.querySelector('.post-date');
                dom.Element? likes = element.querySelector('.post-likes');
                dom.Element? views = element.querySelector('.post-views');
                dom.Element? id = element.querySelector('.post-id');
                dom.Element? realDate = element.querySelector('.post-dateSS');
                dom.Element? comments = element.querySelector('.post-comments');
                customKeywords.add({
                  'writer': writer?.text,
                  'title': title?.text,
                  'category': category?.text,
                  'realDate': realDate?.text,
                  'date': current == date?.text.substring(0, 10)
                      ? date?.text = date.text.substring(10, date.text.length)
                      : date?.text = date.text.substring(2, 10),
                  'likes': likes?.text,
                  'views': views?.text,
                  'comments': comments?.text.substring(1),
                  'id': id?.text,
                  'communityCategory': setCategoryController.setCategory.value
                });
              }
              pageIndexController.increment();
            }
          }
        }
      } else {
        pageIndexController.setUp();
        categoryIndexController.setUp();
        while (true) {
          final Map<String, String> _queryParameters = <String, String>{
            'page': pageIndexController.pageIndex.value.toString(),
          };
          final response = await http.get(Uri.http(ipv4,
              '/community/${boardCategory[categoryIndexController.categoryIndex.value]}', _queryParameters));
          if (response.statusCode == 200) {
            dom.Document document = parser.parse(response.body);
            List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
            List<dom.Element> answerKeywordElements = document.querySelectorAll('.answer-data');
            if (keywordElements.isEmpty) {
              if (categoryIndexController.categoryIndex.value < 4) {
                categoryIndexController.categoryIndex.value++;
                pageIndexController.setUp();
              } else {
                break;
              }
            } else {
              for (var element in keywordElements) {
                dom.Element? writer = element.querySelector('.post-writer');
                dom.Element? title = element.querySelector('.post-title');
                dom.Element? category = element.querySelector('.post-category');
                dom.Element? date = element.querySelector('.post-date');
                dom.Element? likes = element.querySelector('.post-likes');
                dom.Element? views = element.querySelector('.post-views');
                dom.Element? id = element.querySelector('.post-id');
                dom.Element? realDate = element.querySelector('.post-dateSS');
                dom.Element? comments = element.querySelector('.post-comments');
                customKeywords.add({
                  'writer': writer?.text,
                  'title': title?.text,
                  'category': category?.text,
                  'realDate': realDate?.text,
                  'date': current == date?.text.substring(0, 10)
                      ? date?.text = date.text.substring(10, date.text.length)
                      : date?.text = date.text.substring(2, 10),
                  'likes': likes?.text,
                  'views': views?.text,
                  'comments': comments?.text.substring(1),
                  'id': id?.text,
                  'communityCategory': boardCategory[categoryIndexController.categoryIndex.value]
                });
              }
              for(var element in answerKeywordElements){
                dom.Element? title = element.querySelector('.answer-title');
                dom.Element? writer = element.querySelector('.answer-writer');
                dom.Element? date = element.querySelector('.answer-date');
                dom.Element? realDate = element.querySelector('.answer-dateSS');
                dom.Element? parentId = element.querySelector('.answer-parentId');
                dom.Element? id = element.querySelector('.answer-id');
                dom.Element? likes = element.querySelector('.answer-likes');
                dom.Element? views = element.querySelector('.answer-views');
                dom.Element? comments = element.querySelector('.answer-comments');
                dom.Element? category = element.querySelector('.answer-category');
                answerKeywords.add({
                  'parentId' : parentId?.text,
                  'id' : id?.text,
                  'title' : title?.text,
                  'writer' : writer?.text,
                  'date' :current == date?.text.substring(0, 10)
                      ? date?.text = date.text.substring(10, date.text.length)
                      : date?.text = date.text.substring(2, 10),
                  'realDate' : realDate?.text,
                  'likes' : likes?.text,
                  'views' : views?.text,
                  'comments': comments?.text.substring(1),
                  'category': category?.text,
                  'communityCategory': boardCategory[categoryIndexController.categoryIndex.value]
                });
              }
              pageIndexController.increment();
            }
          }
        }
      }
      if (communityCategory== 'all') {
        customKeywords.sort((b, a) => a['realDate'].compareTo(b['realDate']));
      } else {
        customKeywords.sort((b, a) =>
            int.parse(a['comments']).compareTo(int.parse(b['comments'])));
        customKeywords.sort(
                (b, a) => int.parse(a['likes']).compareTo(int.parse(b['likes'])));
        customKeywords.sort(
                (b, a) => int.parse(a['views']).compareTo(int.parse(b['views'])));
      }
      boardListController.boardClear();
      for (var element in customKeywords) {
        boardListController.boardAdd(AddBoard(
          keywords: element,
          index: pageIndexController.pageIndex.value,
          before: communityCategory,//beforeRouteController.before.value,
        ));
        for(var answerElement in answerKeywords){
          if(element['id'] == answerElement['parentId']){
            boardListController.boardAdd(AddBoard(
                index: pageIndexController.pageIndex.value,
                keywords: answerElement,
                before: communityCategory
            ));
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
      customKeywords.clear();
      answerKeywords.clear();
    } else {
      //초기화, 전체, 인기 게시판이 아닐때
      boardListController.boardClear();
      final Map<String, String> _queryParameters = <String, String>{
        'page': pageIndexController.pageIndex.value.toString(),
      };
      final response = await http.get(Uri.http(
          ipv4, '/community/$communityCategory', _queryParameters));
      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);
        List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
        List<dom.Element> answerKeywordElements = document.querySelectorAll('.answer-data');
        if (keywordElements.isEmpty) {
          pageIndexController.decrement();
          loadingController.setFalse();
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
          throw Exception('Failed to load post');
        } else {
          dom.Element? communityCategory = document.querySelector("community-category");
          for (var element in keywordElements) {
            dom.Element? writer = element.querySelector('.post-writer');
            dom.Element? title = element.querySelector('.post-title');
            dom.Element? category = element.querySelector('.post-category');
            dom.Element? date = element.querySelector('.post-date');
            dom.Element? likes = element.querySelector('.post-likes');
            dom.Element? views = element.querySelector('.post-views');
            dom.Element? id = element.querySelector('.post-id');
            dom.Element? realDate = element.querySelector('.post-dateSS');
            dom.Element? comments = element.querySelector('.post-comments');
            keywords.add({
              'writer': writer?.text,
              'title': title?.text,
              'category': category?.text,
              'realDate': realDate?.text,
              'date': current == date?.text.substring(0, 10)
                  ? date?.text = date.text.substring(10, date.text.length)
                  : date?.text = date.text.substring(2, 10),
              'likes': likes?.text,
              'views': views?.text,
              'comments': comments?.text.substring(1),
              'id': id?.text,
              'communityCategory': communityCategory
            });
          }
          for(var element in answerKeywordElements){
            dom.Element? title = element.querySelector('.answer-title');
            dom.Element? writer = element.querySelector('.answer-writer');
            dom.Element? date = element.querySelector('.answer-date');
            dom.Element? realDate = element.querySelector('.answer-dateSS');
            dom.Element? parentId = element.querySelector('.answer-parentId');
            dom.Element? id = element.querySelector('.answer-id');
            dom.Element? likes = element.querySelector('.answer-likes');
            dom.Element? views = element.querySelector('.answer-views');
            dom.Element? comments = element.querySelector('.answer-comments');
            dom.Element? category = element.querySelector('.answer-category');
            answerKeywords.add({
              'parentId' : parentId?.text,
              'id' : id?.text,
              'title' : title?.text,
              'writer' : writer?.text,
              'date' :current == date?.text.substring(0, 10)
                  ? date?.text = date.text.substring(10, date.text.length)
                  : date?.text = date.text.substring(2, 10),
              'realDate' : realDate?.text,
              'likes' : likes?.text,
              'views' : views?.text,
              'comments': comments?.text.substring(1),
              'category': category?.text,
              'communityCategory': boardCategory[categoryIndexController.categoryIndex.value]
            });
          }
          for (var element in keywords) {
            boardListController.boardAdd(AddBoard(
              keywords: element,
              index: pageIndexController.pageIndex.value,
              before: element['communityCategory'],//beforeRouteController.before.value,
            ));
            for(var answerElement in answerKeywords){
              if(element['id'] == answerElement['parentId']){
                boardListController.boardAdd(AddBoard(
                    index: pageIndexController.pageIndex.value,
                    keywords: answerElement,
                    before: element['communityCategory']
                ));
              }
            }
          }
          keywords.clear();
          answerKeywords.clear();
        }
      }
    }
  }
}
