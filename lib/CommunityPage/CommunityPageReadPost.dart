import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:capstone/CommunityPage/CommunityPageReply.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future fetch() async {
    final response = await http
        .get(Uri.http('127.0.0.1:8080', '/community/free/${widget.id}'));
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
     contents = document.querySelector('.contents');
      setState(() {
        //contents = document.querySelector('.contents');
        content = contents?.outerHtml;
        print(contents);
        //printWrapped(document.outerHtml);
      });
    }else{
      print(Uri.http('127.0.0.1:8080', '/community/free${widget.id}'));
      throw Exception('Failed to load post');
    }
  }
  @override
  void initState(){
    content = "";
    fetch();
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
                                            style: CommunityPageTheme.postFont,
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
                                  Get.to(()=>const CommunityPageReply());
                                },
                              ),
                              Container(
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
                              )
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
                      Get.to(()=>const CommunityPageReply());
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