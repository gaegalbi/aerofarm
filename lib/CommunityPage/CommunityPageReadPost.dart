import 'dart:convert';

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:capstone/CommunityPage/CommunityPageReply.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityAddComment.dart';
import '../LoginPage/LoginPageLogin.dart';
import 'CommunityPageFloating.dart';
import 'CommunityPageForm.dart';
final List<Widget> commentList = [];

class CommunityPageReadPost extends StatefulWidget {
  final int index;
  final String id;
  final String writer;
  final String title;
  final String views;
  final String likes;
  final String comments;
  final String realDate;
  final String category;

  const CommunityPageReadPost({Key? key,required this.index, required this.id, required this.writer, required this.title, required this.views, required this.likes, required this.comments, required this.realDate, required this.category,}) : super(key: key);

  @override
  State<CommunityPageReadPost> createState() => _CommunityPageReadPostState();
}

class _CommunityPageReadPostState extends State<CommunityPageReadPost> {
  late String? content;
  late dom.Element? contents;
  late String? isLike;
  late String? likes;
  late int count;
  late ScrollController _scrollController;
  int index = 1;

  Future fetch() async {
    final List<Map<String, dynamic>> customKeywords = [];
    final Map<String, String> _queryParameters = <String, String>{
      'page': index.toString(),
    };

    final response = await http
        .get(Uri.http('127.0.0.1:8080', '/community/${widget.category}/${widget.id}',_queryParameters),
        headers:{
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie":"JSESSIONID=$session",
        }
    );
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      List<dom.Element> keywordElements = document.querySelectorAll('.comment-user-info');
      contents = document.querySelector('.contents');
      isLike = document.querySelector('.isSelected')?.text;
      for (var element in keywordElements) {
        dom.Element? commentWriter = element.querySelector('.commentWriter');
        dom.Element? commentContent = element.querySelector('.commentContent');
        dom.Element? commentDate = element.querySelector('.commentDate');
        customKeywords.add({
          'writer': commentWriter?.text,
          'date': commentDate?.text,
          'content':  commentContent?.text,
        });
      }
      setState(() {
        commentList.clear();
        for (var element in customKeywords) {
          commentList.add(AddComment(
            keywords: element,index: widget.index,id: widget.id,writer: widget.writer,title: widget.title,views: widget.views,likes: widget.likes,comments: widget.comments,realDate: widget.realDate, category: widget.category,
          ));
        }
        content = contents?.outerHtml;
      });
    }else{
      print(Uri.http('127.0.0.1:8080', '/community/free${widget.id}'));
      throw Exception('Failed to load post');
    }
  }
  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      index++;
      keywords.clear();
      fetch();
    }
  }
  @override
  void initState(){
    commentList.clear();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    content = "";
    isLike = "";
    fetch();
    likes=widget.likes;
    count = int.parse(widget.comments);
    super.initState();
  }
  bool floating = false;
  @override
  Widget build(BuildContext context) {
    print(content.toString());
    return GestureDetector(
      onDoubleTap: (){
        setState((){
          floating = !floating;
        });},
      child: Scaffold(
          floatingActionButton: floating? CommunityPageFloating(id: widget.category, type: 'ReadPost', title: widget.title,) : null,
          backgroundColor: MainColor.six,
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
                  child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                // 패딩 설정
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: () {
                  Get.off(()=>CommunityPageForm(category:widget.category));
                },
              )),
            ),
            title: const Text("도시농부", style: MainTheme.title),
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
                      Get.offAll( const MainPage());
                    },
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.03,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.005),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                matchCategory[widget.category]!,
                                style: CommunityPageTheme.title,
                              ),
                              IconButton(
                                splashRadius: 20,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                color: MainColor.three,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.chevron_right,
                                ),
                                onPressed: () {
                                  Get.off(()=> CommunityPageForm(category:widget.category));
                                },
                              ),
                            ],
                          ),
                   /*       Container(
                            decoration: BoxDecoration(
                              color: MainColor.three,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextButton(onPressed: (){},
                              child: const Text(
                                "답글",
                                style: CommunityPageTheme.postFont,
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),),),
                          )*/
                        ],
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.012),
                    child: Text(
                      widget.title,
                      style: CommunityPageTheme.postTitle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.03),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.01),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                          child: Row(
                            children: [
                              //프로필
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.08,
                                backgroundImage:
                                    const AssetImage("assets/images/profile.png"),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width * 0.02,
                                    left:
                                        MediaQuery.of(context).size.width * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(right: 20),
                                            child:  Text(
                                              widget.writer,
                                              style: CommunityPageTheme.commentWriter,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Text(widget.realDate,)
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Row(
                                              children: [
                                                const Text("조회 "),
                                                Text((int.parse(widget.views)+1).toString()),
                                              ],
                                            )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          //height: MediaQuery.of(context).size.height*0.4,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Html(data: content),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 2, color: Colors.white),
                            )),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: const Text(
                                          "댓글",
                                          style: CommunityPageTheme.postFont,
                                        ),
                                      ),
                                      Text(
                                        widget.comments,
                                        style: CommunityPageTheme.postFont,
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                      Get.to(() => CommunityPageReply(index: widget.index,id: widget.id,writer: widget.writer,title: widget.title,views: widget.views,likes: widget.likes,comments: widget.comments,realDate: widget.realDate, category: widget.category, communityCategory: widget.category,));
                                  },
                                ),
                                 if (count < 1) Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: CircleAvatar(
                                          radius:
                                              MediaQuery.of(context).size.width *
                                                  0.08,
                                          backgroundImage: const AssetImage(
                                              "assets/images/profile.png"),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(() => CommunityPageReply(id:widget.id, index: widget.index,likes: widget.likes, comments: widget.comments, title: widget.title, views: widget.views, writer: widget.writer, realDate: widget.realDate, category: widget.category, communityCategory: widget.category,));
                                        },
                                        child: const Text(
                                          "첫 댓글을 입력하세요",
                                          style: CommunityPageTheme.postFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                ) else Column(children: commentList
                                 ,),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 35,
                  ),
                  text: const Text(
                    "목록으로",
                    style: CommunityPageTheme.bottomAppBarList,
                  ),
                  onPressed: () {},
                ),
                Row(
                  children: [
                    AppBarButton(
                      icon: Container(
                        margin: EdgeInsets.only(right: 5),
                        child:  Icon(
                          isLike=="1" ? Icons.favorite : Icons.favorite_outline,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                      text: Text(
                        likes!,
                        style: CommunityPageTheme.bottomAppBarFavorite,
                      ),
                      onPressed: () async {
                        var data = {
                          "postId":widget.id,
                        };
                        var body = json.encode(data);
                        if(isLike=="1"){
                         await http.post(
                            Uri.http('127.0.0.1:8080', '/deleteLike'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie":"JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                          setState((){
                            isLike="0";
                            likes = (int.parse(likes!)-1).toString();
                          });
                        }else{
                          await http.post(
                            Uri.http('127.0.0.1:8080', '/createLike'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie":"JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                          setState((){
                            isLike="1";
                            likes = (int.parse(likes!)+1).toString();
                          });
                        }
                      },
                    ),
                    AppBarButton(
                      icon: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.chat,
                          size: 35,
                        ),
                      ),
                      text: Text(
                        widget.comments,
                        style: CommunityPageTheme.bottomAppBarReply,
                      ),
                      onPressed: () {
                        Get.to(() => CommunityPageReply(index: widget.index,id: widget.id,writer: widget.writer,title: widget.title,views: widget.views,likes: widget.likes,comments: widget.comments,realDate: widget.realDate, category: widget.category, communityCategory:widget.category ,));
                      },
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

@immutable
class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}