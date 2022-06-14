import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../CommunityPageCustomLib/CommunityAddBoard.dart';
import '../CommunityPageCustomLib/CommunityNotice.dart';
import 'CommunityPageFloating.dart';

final List<Widget> boardList = [];
final List<Map<String, dynamic>> keywords = [];
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

class CommunityPageForm extends StatefulWidget {
  final String category;

  const CommunityPageForm({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CommunityPageForm> createState() => _CommunityPageFormState();
}

class _CommunityPageFormState extends State<CommunityPageForm> {
  late ScrollController _scrollController;
  int index = 1;
  late List<Map<String, dynamic>> customKeywords = [];
  Future fetch() async {
    List<String> boardCategory = ["free","information","question","picture","trade"];
    String current = dateFormat.format(DateTime.now());
    if(widget.category=='all' || widget.category=='hot') {
      int i=1;
      int categoryIndex=0;
      final List<Map<String, dynamic>> customKeywords = [];
      while(true) {
        final Map<String, String> _queryParameters = <String, String>{
          'page': i.toString(),
        };
        final response = await http.get(Uri.http(
            '127.0.0.1:8080', '/community/${boardCategory[categoryIndex]}',
            _queryParameters));
        if (response.statusCode == 200) {
          dom.Document document = parser.parse(response.body);
          List<dom.Element> keywordElements =
          document.querySelectorAll('.post-data');
          if (keywordElements.isEmpty) {
            if (categoryIndex < 4) {
              setState(() {
                categoryIndex++;
                i = 1;
              });
              print(categoryIndex);
            }else{
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
              dom.Element? realDate = element.querySelector('.date');
              customKeywords.add({
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
                    title.text.lastIndexOf('(') + 1,
                    title.text.lastIndexOf(')')),
                'id': id?.text,
              });
            }
            i++;
          }
        }
      }
      if(widget.category =='all') {
        customKeywords.sort((b, a) => a['realDate'].compareTo(b['realDate']));
      }else{
        customKeywords.sort((b, a) => a['comments'].compareTo(b['comments']));
      }
      setState(() {
        for (var element in customKeywords) {
          boardList.add(AddBoard(
            keywords: element,
            index: index,
          ));
        }
        customKeywords.clear();
      });
    }else{
      final Map<String, String> _queryParameters = <String, String>{
        'page': index.toString(),
      };
      final response = await http.get(Uri.http('127.0.0.1:8080', '/community/${widget.category}', _queryParameters));
      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);
        List<dom.Element> keywordElements =
        document.querySelectorAll('.post-data');
        if (keywordElements.isEmpty) {
          print(Uri.http('127.0.0.1:8080', '/community/${widget.category}',
              _queryParameters));
          index--;
          throw Exception('Failed to load post');
        } else {
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
            });
          }
          setState(() {
            for (var element in keywords) {
              boardList.add(AddBoard(
                keywords: element,
                index: index,
              ));
            }
            keywords.clear();
            print(Uri.http('127.0.0.1:8080', '/community/${widget.category}',
                _queryParameters));
          });
        }
      }
    }
  }

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent && !(widget.category=='all' || widget.category=='hot')) {
        index++;
        keywords.clear();
        fetch();
      }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    boardList.clear();
    boardList.add(notice());
    fetch();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CommunityPageFloating(id: widget.category,),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MainColor.six,
        toolbarHeight: MainSize.toobarHeight,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.2106,
        leading: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: FittedBox(
              child: Builder(
            builder: (context) => IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              color: MainColor.three,
              iconSize: 50,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )),
        ),
        title: const Text(
          "도시농부",
          style: MainTheme.title,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Builder(
              builder: (context) => IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Get.off(() => const MainPage());
                },
              ),
            ),
          )
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        child: const Drawer(
          backgroundColor: Colors.black,
          child: CommunityPageDrawer(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.04,
          0,
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.width * 0.04,
        ),
        color: MainColor.six,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.03,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  matchCategory[widget.category]!,
                  style: CommunityPageTheme.title,
                )),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.014,
              ),
              height: MediaQuery.of(context).size.height * 0.69,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: boardList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < boardList.length) {
                            return boardList[index];
                          } else {
                            return Container();
                          }
                        })),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
