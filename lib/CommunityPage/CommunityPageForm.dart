import 'package:capstone/CommunityPage/CommunityPageReadPost.dart';
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
import '../CommunityPageCustomLib/CommunityTitleButton.dart';
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
  late ScrollController _categoryController;
  int index = 1;
  int categoryIndex=0;
  int i=1;
  late List<Map<String, dynamic>> customKeywords = [];
  List<String> boardCategory = ["free","information","question","picture","trade"];
  bool loading = true;
  bool floating= false;
  List<bool> category= [true,false,false,false,false,false,];
  String setCategory = "all";

  void categoryClick(int index){
    for(int i=0;i<category.length;i++){
      if(i!=index){
        category[i]=false;
      }else{
        category[i]=true;
        switch(i){
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
    if(widget.category=='all' || widget.category=='hot') {
      final List<Map<String, dynamic>> customKeywords = [];
      if(setCategory!="all"){
        i = 1;
        while(true) {
          final Map<String, String> _queryParameters = <String, String>{
            'page': i.toString(),
          };
          final response = await http.get(Uri.http(
              '127.0.0.1:8080', '/community/$setCategory',
              _queryParameters));
          if (response.statusCode == 200) {
            dom.Document document = parser.parse(response.body);
            List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
            if (keywordElements.isEmpty) {
                print(i);
                print("break work");
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
                //print(realDate?.text);
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
                  'communityCategory':setCategory
                });
              }
              i++;
            }
          }
        }
      }else{
        i=0;
        categoryIndex =0;
        while(true) {
          final Map<String, String> _queryParameters = <String, String>{
            'page': i.toString(),
          };
          final response = await http.get(Uri.http(
              '127.0.0.1:8080', '/community/${boardCategory[categoryIndex]}',
              _queryParameters));
          if (response.statusCode == 200) {
            dom.Document document = parser.parse(response.body);
            List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
            if (keywordElements.isEmpty) {
              if (categoryIndex < 4) {
                setState(() {
                  categoryIndex++;
                  i = 1;
                });
                //print(categoryIndex);
              }else{
                print(categoryIndex);
                print(i);
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
                //print(realDate?.text);
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
                  'communityCategory':boardCategory[categoryIndex]
                });

              }
              i++;
            }
          }
        }
      }
      if(widget.category =='all') {
        customKeywords.sort((b, a) => a['realDate'].compareTo(b['realDate']));
      }else{
        customKeywords.sort((b, a) => int.parse(a['comments']).compareTo(int.parse(b['comments'])));
        customKeywords.sort((b, a) => int.parse(a['likes']).compareTo(int.parse(b['likes'])));
        customKeywords.sort((b, a) => int.parse(a['views']).compareTo(int.parse(b['views'])));
      }
      setState(() {
        boardClear();
        for (var element in customKeywords) {
          boardList.add(AddBoard(
            keywords: element,
            index: index, category: widget.category, before: widget.category,
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
          setState((){
            index--;
            loading = false;
            if(boardList.length ==1){
              boardList.add(
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.345),
                      alignment: Alignment.center,
                      child:const Text("게시글이 없습니다.",style: CommunityPageTheme.announce,)
              )
              );
            }
          });
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
              'communityCategory':widget.category
            });
          }
          setState(() {
            for (var element in keywords) {
              boardList.add(AddBoard(
                keywords: element,
                index: index, category: widget.category, before: widget.category,
              ));
            }
            keywords.clear();
          });
        }
      }
    }
  }

  void boardClear(){
    boardList.clear();
    boardList.add(notice());
  }

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent && !(widget.category=='all' || widget.category=='hot')) {
        index++;
        keywords.clear();
        fetch();
      }
      if (_scrollController.offset ==_scrollController.position.minScrollExtent) {
        //keywords.clear();
        setState((){
          commentList.clear();
          boardClear();
          index = 1;
          categoryIndex = 0;
          i=1;
          loading = true;
          fetch();
          Future.delayed(const Duration(microseconds: 100), () {
            loading = false;
          });
        });
      }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    commentList.clear();
    boardClear();
    fetch();
    Future.delayed(const Duration(microseconds: 100), () {
      loading = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
        setState((){
          floating = !floating;
        });},
      child: Scaffold(
        floatingActionButton: floating? CommunityPageFloating(id: widget.category, type: 'Form', title: "",) : null,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    matchCategory[widget.category]!,
                    style: CommunityPageTheme.title,
                  ),
                  widget.category =="hot" ?  Container(
                    height: MediaQuery.of(context).size.height * 0.039,
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.021,),
                    child: ListView(
                      controller: _categoryController,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        TitleButton(title: "전체",onPressed: (){
                          setState((){
                            categoryClick(0);
                            fetch();
                          });
                        }, style: category[0]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                        TitleButton(title: "자유",onPressed: (){
                          setState((){
                            categoryClick(1);
                            fetch();
                          });
                        }, style: category[1]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                        TitleButton(title: "사진",onPressed: (){
                          setState((){
                            categoryClick(2);
                            fetch();
                          });
                        }, style: category[2]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                        TitleButton(title: "정보",onPressed: (){
                          setState((){
                            categoryClick(3);
                            fetch();
                          });
                        }, style: category[3]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                        TitleButton(title: "질문",onPressed: (){
                          setState((){
                            categoryClick(4);
                            fetch();
                          });
                        }, style: category[4]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                        TitleButton(title: "거래",onPressed: (){
                          setState((){
                            categoryClick(5);
                            fetch();
                          });
                        }, style: category[5]? CommunityPageTheme.titleButtonTrue:CommunityPageTheme.titleButtonFalse),
                      ],
                    ),
                  ) : Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.014,
                ),
                height: MediaQuery.of(context).size.height * 0.69,
                child: Column(children: [
                  !loading?Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: boardList.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < boardList.length) {
                              return boardList[index];
                            } else {
                              return Container();
                            }
                          })):const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(color: MainColor.three,)
                      )
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
