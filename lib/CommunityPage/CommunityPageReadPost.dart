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
import 'CommunityPageForm.dart';

class CommunityPageReadPost extends StatefulWidget {
  final int index;
  final String id;
  final String writer;
  final String title;
  final String views;
  final String likes;
  final String comments;
  final String realDate;

  const CommunityPageReadPost({Key? key,required this.index, required this.id, required this.writer, required this.title, required this.views, required this.likes, required this.comments, required this.realDate}) : super(key: key);

  @override
  State<CommunityPageReadPost> createState() => _CommunityPageReadPostState();
}

class _CommunityPageReadPostState extends State<CommunityPageReadPost> {
  late String? content;
  late dom.Element? contents;
  late int count;
  final List<Widget> commentList = [];
  late ScrollController _scrollController;
  int index = 1;

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String subString(String str,int index, int cnt){
   String tmp="";
   String a;
/*    if(str.length<cnt){
      if(str.length%2==0){
        a = str.substring(0 + (str.length/2).round());
        tmp =a + "\n" + str.substring((str.length/2).round()+1,str.length);
      }else{
        a = str.substring(0 + (str.length/2).round());
        tmp =a + "\n" + str.substring((str.length/2).round()-1,str.length);
      }
      return tmp;
    }*/
   for(int  i=0;i<=index;i++){
       a = str.substring(0 + (cnt * i), cnt + (cnt * i));
       if (i == index) {
         if(str.length%2==0){
           tmp += a;
         }else{
           tmp += a + str.substring((cnt+cnt*i),str.length);
         }
       } else {
         tmp += a + "\n";
       }
   }
   return tmp;
  }
  Future fetch() async {
    final List<Map<String, dynamic>> customKeywords = [];
    final Map<String, String> _queryParameters = <String, String>{
      'page': index.toString(),
    };

    final response = await http
        .get(Uri.http('127.0.0.1:8080', '/community/free/${widget.id}',_queryParameters));
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      List<dom.Element> keywordElements = document.querySelectorAll('.comment-user-info');
      contents = document.querySelector('.contents');
      for (var element in keywordElements) {
        dom.Element? commentWriter = element.querySelector('.commentWriter');
        dom.Element? commentContent = element.querySelector('.commentContent');
        dom.Element? commentDate = element.querySelector('.commentDate');
        customKeywords.add({
          'writer': commentWriter?.text,
          'date': commentDate?.text,
          'content': commentContent!.text.length<=15?
          commentContent.text :
          subString(commentContent.text,commentContent.text.length%10,15)
        ,
        });
      }
/*      print(Uri.http('127.0.0.1:8080', '/community/free/${widget.id}'));
      print(customKeywords);*/

      setState(() {
        //contents = document.querySelector('.contents');
        for (var element in customKeywords) {
          commentList.add(AddComment(
            keywords: element,
          ));
        }
        content = contents?.outerHtml;
        //printWrapped(document.outerHtml);
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
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    content = "";
    fetch();
    count = int.parse(widget.comments);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                Get.off(()=>const CommunityPageForm(category:'all'));
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "전체게시판",
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
                            Get.off(()=>const CommunityPageForm(category:'all'));
                          },
                        )
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
                                      SizedBox(
                                        width: 54,
                                        height: 30,
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Row(
                                              children: const [
                                                Icon(
                                                  Icons.chat,
                                                  color: MainColor.three,
                                                ),
                                                Text(
                                                  "채팅",
                                                  style: CommunityPageTheme.postButton,
                                                ),
                                              ],
                                            )),
                                      ),
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
                                              Text(widget.views),
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
                                    Get.to(() => CommunityPageReply(id:widget.id, index: widget.index, likes: widget.likes, comments: widget.comments, title: widget.title, views: widget.views, writer: widget.writer, realDate: widget.realDate,));
                                },
                              ),
                               count < 1? Container(
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
                                    const Text(
                                      "첫 댓글을 입력하세요",
                                      style: CommunityPageTheme.postFont,
                                    ),
                                  ],
                                ),
                              ) : Column(children: commentList
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
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                    text: Text(
                      widget.likes,
                      style: CommunityPageTheme.bottomAppBarFavorite,
                    ),
                    onPressed: () {
                      Get.off(()=>const CommunityPageForm(category:'all'));
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
                      Get.to(() => CommunityPageReply(id:widget.id, index: widget.index, likes: widget.likes, comments: widget.comments, title: widget.title, views: widget.views, writer: widget.writer, realDate: widget.realDate,));
                    },
                  )
                ],
              ),
            ],
          ),
        ));
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