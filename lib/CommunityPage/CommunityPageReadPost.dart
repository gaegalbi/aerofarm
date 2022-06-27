import 'dart:convert';

import 'package:capstone/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:capstone/CommunityPage/CommunityPageReply.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../LoginPage/LoginPageLogin.dart';
import 'CommunityPageFloating.dart';
import 'CommunityPageForm.dart';

class CommunityPageReadPost extends StatefulWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;

  const CommunityPageReadPost({Key? key,required this.index,required this.keywords, required this.before,}) : super(key: key);

  @override
  State<CommunityPageReadPost> createState() => _CommunityPageReadPostState();
}

class _CommunityPageReadPostState extends State<CommunityPageReadPost> {
  final readPostController = Get.put(ReadPostController());
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());

  late String? content;
  late dom.Element? contents;
  late String? likes;
  late int count;
  late ScrollController _scrollController;
  bool floating = false;

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      pageIndexController.increment();
      //fetch();
      fetch(widget.keywords['communityCategory'],true);
    }
  }
  @override
  void initState(){
    //commentListController.commentClear();
    pageIndexController.setUp();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    content = "";
    //fetch();
    readPostController.setId(widget.keywords['id']);
    fetch(widget.keywords['communityCategory'],true);

    //CommunityPageReply 에서 뒤로가기 아이콘 클릭 시 null 방지
    //addComment 에 postKeywords 로 post 값 줌
    postKeywords.clear();
    postKeywords.addAll(widget.keywords);

    likes=widget.keywords['likes'];
    //count = int.parse(widget.keywords['comments']);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
          floatingActionButton: floating? CommunityPageFloating(id: widget.keywords['communityCategory'], type: 'ReadPost', title: widget.keywords['title'],) : null,
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
                  if(widget.before=="all"||widget.before=='hot'){
                    Get.offAll(()=>CommunityPageForm(category: widget.before));
                  }else{
                    Get.offAll(()=>CommunityPageForm(category:widget.keywords['communityCategory']));
                  }
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
                      Get.offAll(()=>const MainPage());
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
                                matchCategory[widget.keywords['communityCategory']]!,
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
                                  Get.off(()=> CommunityPageForm(category:widget.keywords['communityCategory']));
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
                      widget.keywords['title'],
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
                                            margin: const EdgeInsets.only(right: 20),
                                            child:  Text(
                                              widget.keywords['writer'],
                                              style: CommunityPageTheme.commentWriter,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Text(widget.keywords['realDate'],)
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Row(
                                              children: [
                                                const Text("조회 "),
                                                Text((int.parse(widget.keywords['views'])+1).toString()),
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
                          child: Obx(()=>Html(data: readPostController.content.value)),
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
                                      Obx(()=>Text(
                                        commentListController.commentList.length.toString(),//widget.keywords['comments'],
                                        style: CommunityPageTheme.postFont,
                                      )),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                      Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                                  },
                                ),
                                 Obx(()=> commentListController.commentList.isEmpty? Container(
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
                                          print(widget.keywords);
                                          Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                                        },
                                        child: const Text(
                                          "첫 댓글을 입력하세요",
                                          style: CommunityPageTheme.postFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : InkWell(
                                   onTap: (){
                                     Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                                   },
                                  child: Column(children: commentListController.commentList
                                   ,),
                                ),)
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
                        child:  Obx(()=>Icon(
                          readPostController.isLike.value == true ? Icons.favorite : Icons.favorite_outline,
                          size: 35,
                          color: Colors.red,
                        ),)
                      ),
                      text: Text(
                        likes!,
                        style: CommunityPageTheme.bottomAppBarFavorite,
                      ),
                      onPressed: () async {
                        //누를때 한번 더 확인
                        final Map<String, String> _queryParameters = <String, String>{
                          'page': pageIndexController.pageIndex.value.toString(),
                        };
                        final response = await http
                            .get(Uri.http(ipv4, '/community/${widget.keywords['communityCategory']}/${widget.keywords['id']}',_queryParameters),
                            headers:{
                              "Content-Type": "application/x-www-form-urlencoded",
                              "Cookie":"JSESSIONID=$session",
                            }
                        );
                        if (response.statusCode == 200) {
                          dom.Document document = parser.parse(response.body);
                          printWrapped(document.outerHtml);
                          readPostController.setContent(
                              document.querySelector('.post-contents')!.outerHtml);
                          readPostController.setIsLike(document.querySelector('.isSelected')!.text);
                          likes = document.querySelector('.post-likes')!.text;
                        }
                        var data = {
                          "postId":widget.keywords['id'],
                        };
                        var body = json.encode(data);
                        if(readPostController.isLike.isTrue){
                         await http.post(
                            Uri.http(ipv4, '/deleteLike'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie":"JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                         readPostController.toggleLike();
                          setState((){
                            likes = (int.parse(likes!)-1).toString();
                          });
                        }else{
                          await http.post(
                            Uri.http(ipv4, '/createLike'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie":"JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                          readPostController.toggleLike();
                          setState((){
                            print("+1");
                            print(likes);
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
                      text: Obx(()=>Text(
                        commentListController.commentList.length.toString(),//widget.keywords['comments'],
                        style: CommunityPageTheme.bottomAppBarReply,
                      )),
                      onPressed: () {
                        Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before ,));
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