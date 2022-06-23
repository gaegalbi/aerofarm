import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import '../themeData.dart';
import 'CommunityAddBoard.dart';
import 'CommunityNotice.dart';

//final List<Widget> boardList = [];
final List<Widget> commentList = [];
final List<Map<String, dynamic>> keywords = [];
final List<Map<String, dynamic>> customKeywords = [];
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
  final before = "all".obs;

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

List<bool> category = [
  true,
  false,
  false,
  false,
  false,
  false,];
String setCategory = "all";

void categoryClick(int index) {
  for (int i = 0; i < category.length; i++) {
    if (i != index) {
      category[i] = false;
    } else {
      category[i] = true;
      switch (i) {
        case 1:
          setCategory = "free";
          break;
        case 2:
          setCategory = "picture";
          break;
        case 3:
          setCategory = "information";
          break;
        case 4:
          setCategory = "question";
          break;
        case 5:
          setCategory = "trade";
          break;
        default:
          setCategory = "all";
          break;
      }
    }
  }
}

Future fetch() async {
  String current = dateFormat.format(DateTime.now());
  final categoryIndexController = Get.put(CategoryIndexController());
  final pageIndexController = Get.put(PageIndexController());
  final loadingController = Get.put(LoadingController());
  final beforeRouteController = Get.put(BeforeRouteController());
  final boardListController = Get.put(BoardListController());

  if (beforeRouteController.before.value == 'all' || beforeRouteController.before.value == 'hot') {
    //final List<Map<String, dynamic>> customKeywords = [];
    customKeywords.clear();
    if (setCategory != "all") {
      pageIndexController.setUp();
      while (true) {
        final Map<String, String> _queryParameters = <String, String>{
          'page': pageIndexController.pageIndex.value.toString(),
        };
        final response = await http.get(Uri.http(
            '127.0.0.1:8080', '/community/$setCategory', _queryParameters));
        if (response.statusCode == 200) {
          dom.Document document = parser.parse(response.body);
          List<dom.Element> keywordElements =
          document.querySelectorAll('.post-data');
          if (keywordElements.isEmpty) {
           /* print(i);
            print("break work");*/
            break;
          } else {
            for (var element in keywordElements) {
              dom.Element? writer = element.querySelector('.writer');
              dom.Element? title = element.querySelector('.title-f-sort');
              dom.Element? category = element.querySelector('.f-filter-color-b');
              dom.Element? date = element.querySelector('.date');
              dom.Element? likes = element.querySelector('.likes');
              dom.Element? views = element.querySelector('.views');
              dom.Element? id = element.querySelector('.post-id');
              dom.Element? realDate = element.querySelector('.realDate');
              customKeywords.add({
                'writer': writer?.text,
                'title':
                title?.text.substring(0, title.text.lastIndexOf('(')),
                'category': category?.text,
                'realDate': realDate?.text,
                'date': current == date?.text.substring(0, 10)
                    ? date?.text = date.text.substring(10, date.text.length)
                    : date?.text = date.text.substring(2, 10),
                'likes': likes?.text,
                'views': views?.text,
                'comments': title?.text.substring(
                    title.text.lastIndexOf('(') + 1,
                    title.text.lastIndexOf(')')),
                'id': id?.text,
                'communityCategory': setCategory
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
        final response = await http.get(Uri.http('127.0.0.1:8080',
            '/community/${boardCategory[categoryIndexController.categoryIndex.value]}', _queryParameters));
        if (response.statusCode == 200) {
          dom.Document document = parser.parse(response.body);
          List<dom.Element> keywordElements =
          document.querySelectorAll('.post-data');
          if (keywordElements.isEmpty) {
            if (categoryIndexController.categoryIndex.value < 4) {
              categoryIndexController.categoryIndex.value++;
              pageIndexController.setUp();
              //print(categoryIndex);
            } else {
              print(categoryIndexController.categoryIndex.value);
              print(pageIndexController.pageIndex.value);
              print("break work");
              break;
            }
          } else {
            for (var element in keywordElements) {
              dom.Element? writer = element.querySelector('.writer');
              dom.Element? title = element.querySelector('.title-f-sort');
              dom.Element? category = element.querySelector('.f-filter-color-b');
              dom.Element? date = element.querySelector('.date');
              dom.Element? likes = element.querySelector('.likes');
              dom.Element? views = element.querySelector('.views');
              dom.Element? id = element.querySelector('.post-id');
              dom.Element? realDate = element.querySelector('.realDate');
              customKeywords.add({
                'writer': writer?.text,
                'title':
                title?.text.substring(0, title.text.lastIndexOf('(')),
                'category': category?.text,
                'realDate': realDate?.text,
                'date': current == date?.text.substring(0, 10)
                    ? date?.text = date.text.substring(10, date.text.length)
                    : date?.text = date.text.substring(2, 10),
                'likes': likes?.text,
                'views': views?.text,
                'comments': title?.text.substring(
                    title.text.lastIndexOf('(') + 1,
                    title.text.lastIndexOf(')')),
                'id': id?.text,
                'communityCategory': boardCategory[categoryIndexController.categoryIndex.value]
              });
            }
            pageIndexController.increment();
          }
        }
      }
    }
    if (beforeRouteController.before.value == 'all') {
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
          before: beforeRouteController.before.value,
        ));
      }
      customKeywords.clear();
  } else {
    final Map<String, String> _queryParameters = <String, String>{
      'page': pageIndexController.pageIndex.value.toString(),
    };
    final response = await http.get(Uri.http(
        '127.0.0.1:8080', '/community/${beforeRouteController.before.value}', _queryParameters));
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      List<dom.Element> keywordElements =
      document.querySelectorAll('.post-data');
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
          dom.Element? writer = element.querySelector('.writer');
          dom.Element? title = element.querySelector('.title-f-sort');
          dom.Element? category = element.querySelector('.f-filter-color-b');
          dom.Element? date = element.querySelector('.date');
          dom.Element? likes = element.querySelector('.likes');
          dom.Element? views = element.querySelector('.views');
          dom.Element? id = element.querySelector('.post-id');
          dom.Element? realDate = element.querySelector('.date');
          keywords.add({
            'writer': writer?.text,
            'title': title?.text.substring(0, title.text.lastIndexOf('(')),
            'category': category?.text,
            'realDate': realDate?.text,
            'date': current == date?.text.substring(0, 10)
                ? date?.text = date.text.substring(10, date.text.length)
                : date?.text = date.text.substring(2, 10),
            'likes': likes?.text,
            'views': views?.text,
            'comments': title?.text.substring(
                title.text.lastIndexOf('(') + 1, title.text.lastIndexOf(')')),
            'id': id?.text,
            'communityCategory': beforeRouteController.before.value
          });
        }
        for (var element in keywords) {
          boardListController.boardAdd(AddBoard(
            keywords: element,
            index: pageIndexController.pageIndex.value,
            before: beforeRouteController.before.value,
          ));
        }
        keywords.clear();
      }
    }
  }
}