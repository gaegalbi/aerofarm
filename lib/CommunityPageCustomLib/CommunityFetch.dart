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
final List<Map<String, dynamic>> customKeywords = [];
final Map<String, dynamic> postKeywords = {};

final dateFormat = DateFormat('yyyy.MM.dd');
final Map<String, String> matchCategory = {
  "all": "전체게시판",
  "hot": "인기게시판",
  "free": "자유게시판",
  "information": "정보게시판",
  "question": "질문게시판",
  "picture": "사진게시판",
  "trade": "거래게시판"
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

  void boardAdd(Widget widget){
    boardList.add(widget);
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
  final setCategory = "all".obs;
  final List<bool> category = [true, false, false, false, false, false,].obs;

  void categoryClick(int index) {
    for (int i = 0; i < category.length; i++) {
      if (i != index) {
        category[i]= false;
      } else {
        category[i] = true;
        switch (i) {
          case 1:
            setCategory.value = "free";
            break;
          case 2:
            setCategory.value = "picture";
            break;
          case 3:
            setCategory.value = "information";
            break;
          case 4:
            setCategory.value = "question";
            break;
          case 5:
            setCategory.value = "trade";
            break;
          default:
            setCategory.value = "all";
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
    //pageIndexController.setUp();
    final Map<String, String> _queryParameters = <String, String>{
      'page': pageIndexController.pageIndex.value.toString(),
    };
    final response = await http
        .get(Uri.http(ipv4, '/community/$communityCategory}/${readPostController.id.value}',_queryParameters),
        headers:{
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie":"JSESSIONID=$session",
        }
    );
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      List<dom.Element> keywordElements = document.querySelectorAll('.comment-info');
      readPostController.setContent(document.querySelector('.post-contents')!.outerHtml);
      readPostController.setIsLike(document.querySelector('.isSelected')!.text);
      for (var element in keywordElements) {
        dom.Element? commentWriter = element.querySelector('.comment-writer');
        dom.Element? commentContent = element.querySelector('.comment-content');
        dom.Element? commentDate = element.querySelector('.comment-date');
        customKeywords.add({
          'writer': commentWriter?.text,
          'date': commentDate?.text,
          'content':  commentContent?.text,
          'communityCategory' : communityCategory,
          'id' : readPostController.id.value
        });
      }
      //commentListController.commentClear();
      for (var element in customKeywords) {
        commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value ,keywords: element, before: communityCategory,//beforeRouteController.before.value,
        ));
      }
    }else{
      throw Exception('Failed to load post');
    }
  }else{
    boardListController.boardList.clear();
    if (communityCategory== 'all' || communityCategory == 'hot') {
      customKeywords.clear();
      if (setCategoryController.setCategory.value!="all") {
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
              /*pageIndexController.decrement();
            loadingController.setFalse();*/
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
            List<dom.Element> keywordElements =
            document.querySelectorAll('.post-data');
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
    } else {
      //초기화
      boardListController.boardClear();
      final Map<String, String> _queryParameters = <String, String>{
        'page': pageIndexController.pageIndex.value.toString(),
      };
      final response = await http.get(Uri.http(
          ipv4, '/community/$communityCategory', _queryParameters));
      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);
        List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
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
          /*dom.Element? communityCategory = document.querySelector("community-category");*/
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
          for (var element in keywords) {
            boardListController.boardAdd(AddBoard(
              keywords: element,
              index: pageIndexController.pageIndex.value,
              before: communityCategory,//beforeRouteController.before.value,
            ));
          }
          keywords.clear();
        }
      }
  }

  }
}