import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/CommunityPage/CommunityPageReadPost.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'CommunityConnect.dart';
import 'CommunityPageFloating.dart';

final List<Widget> boardList = [];
final List<Map<String, dynamic>> keywords = [];
final dateFormat = DateFormat('yyyy.MM.dd');

class CommunityPageAll extends StatefulWidget {
  const CommunityPageAll({Key? key}) : super(key: key);

  @override
  State<CommunityPageAll> createState() => _CommunityPageAllState();
}

void fetchPost() async {
  String current = dateFormat.format(DateTime.now());
  //final response = await http.get(Uri.http('172.25.2.57:8080', '/community/free'));
  final response = await http.get(Uri.http('127.0.0.1:8080', '/community/free'));
  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);
    List<dom.Element> keywordElements = document.querySelectorAll('.post-data');
    //List<Map<String, dynamic>> keywords = [];
    //print(keywordElements);
    for (var element in keywordElements) {
      dom.Element? writer = element.querySelector('.writer');
      dom.Element? title = element.querySelector('.title-f-sort');
      dom.Element? category = element.querySelector('.f-filter-color-b');
      dom.Element? date = element.querySelector('.date');
      dom.Element? likes= element.querySelector('.likes');
      dom.Element? views = element.querySelector('.views');
      if(current == date?.text.substring(0,10)){
        date?.text = date.text.substring(10,date.text.length);
      }else{
        date?.text = date.text.substring(2,10);
      }
      keywords.add({
        'writer': writer?.text,
        'title': title?.text,
        'category': category?.text,
        'date': date?.text,
        'likes': likes?.text,
        'views': views?.text,
      });
    }
  } else {
    throw Exception('Failed to load post');
  }
}

class _CommunityPageAllState extends State<CommunityPageAll> {
  late Future<Post> post;
  //late String current;

  @override
  void initState() {
    boardList.clear();
    fetchPost();
    addBoard();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: const CommunityPageFloating(),
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
              // 패딩 설정
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
                  Get.off(()=>const MainPage());
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
                child: const Text(
                  "전체게시판",
                  style: CommunityPageTheme.title,
                )),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.014,
              ),
              height: MediaQuery.of(context).size.height * 0.69,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: boardList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return boardList[index];
                          })),
                ]
              ),
              ),

          ],
        ),
      ),
    );
  }
}

void addBoard(){
  //공지사항부터 추가
  boardList.add(
      Container(
        padding: EdgeInsets.only(
            left: Get.width * 0.05,
            right: Get.width * 0.05,
            bottom: Get.height * 0.012),
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.white),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: Get.width * 0.015),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "필독",
                style: CommunityPageTheme.main,
              ),
            ),
            const Text(
              "도시농부 서비스 안내",
              style: CommunityPageTheme.main,
            ),
          ],
        ),
      )
  );
  for(var element in keywords.reversed.toList()){
    boardList.add(AddBoard(index: element));
  }
  keywords.clear();
}

class AddBoard extends StatelessWidget {
 final Map<String, dynamic> index;

  const AddBoard({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.white),
          )),
      child: InkWell(
        onTap: () {
          Get.to(()=>const CommunityPageReadPost());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:
              MediaQuery.of(context).size.width * 0.7,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width *
                      0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .size
                              .height *
                              0.008),
                      child: Text(
                        index['title'],
                        style: CommunityPageTheme.main,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Flexible(
                         flex: 3,
                         child: Container(
                           child: Text(
                            index['writer'],
                            overflow: TextOverflow.ellipsis,
                            style: CommunityPageTheme.sub,
                      ),
                         ),
                       ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          index['date'],
                          style: CommunityPageTheme.sub,
                        ),
                      ),
                     Flexible(
                       flex: 7,
                         child: Row(
                       children: [
                         Flexible(
                           flex: 1,
                           child: Row(
                             children: [
                               const Text(
                                 "조회 ",
                                 style: CommunityPageTheme.sub,
                               ),
                               Text(
                                 index['views'],
                                 style: CommunityPageTheme.sub,
                               ),
                             ],
                           ),
                         ),
                         Flexible(
                           flex: 1,
                           child: Row(
                             children: [
                               const Text(
                                 "추천 ",
                                 style: CommunityPageTheme.sub,
                               ),
                               Text(
                                 index['likes'],
                                 style: CommunityPageTheme.sub1,
                               ),
                             ],
                           ),
                         )
                       ],
                     ))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height *
                  0.08,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : const [
                  Text(
                  "0",
                  style: CommunityPageTheme.sub,
                  textAlign: TextAlign.center,
                ),
                  Text(
                    "댓글",
                    style: CommunityPageTheme.sub,
                    textAlign: TextAlign.center,
                  ),
                ]
              ),
              decoration: BoxDecoration(
                  color: MainColor.one,
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
