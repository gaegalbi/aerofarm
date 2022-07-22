import 'dart:convert';

import 'package:capstone/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
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
  final replyDetailController = Get.put(ReplyDetailListController());
  final loadingController = Get.put(LoadingController());

  late String? content;
  late dom.Element? contents;
  late String? likes;
  late int count;
  late ScrollController _scrollController;
  bool floating = false;
  String date = "";

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      pageIndexController.increment();
      //loadReadPostContent(widget.keywords['id'], widget.keywords['category']);
    }
  }
  @override
  void initState(){
    pageIndexController.setUp();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    //게시글 내용 불러오기
    readPostContent(widget.keywords['id'], widget.keywords['category']).then((value) => loadingController.setFalse());

    replyDetailController.replyDetailSetUpBefore("ReadPost");
    replyDetailController.replyDetailSetUpBackRoute(widget.index, widget.keywords, widget.before);

    //null 방지
    content = "";
    likes = widget.keywords['likeCount'].toString();

    //CommunityPageReply 에서 뒤로가기 아이콘 클릭 시 null 방지
    //addComment 에 postKeywords 로 post 값 줌
    postKeywords.clear();
    postKeywords.addAll(widget.keywords);
    //날짜 변경
    date = dateInfoFormat.format(DateTime.parse(widget.keywords['modifiedDate']));

   print(widget.keywords);
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
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: floating? CommunityPageFloating(keywords: widget.keywords, type: 'ReadPost',before: widget.before,) : null,
          backgroundColor: MainColor.six,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: MainColor.six,
            toolbarHeight: MainSize.toolbarHeight,
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
                  replyDetailController.replyDetailSetUp();
                  if(widget.before=="ALL"||widget.before=='HOT'){
                    Get.offAll(()=>CommunityPageForm(category: widget.before));
                  }else if(widget.before=="MyActivity"){
                    Get.back();
                  }
                  else{
                    Get.offAll(()=>CommunityPageForm(category:widget.keywords['category']));
                  }
                },
              )),
            ),
            title: const Text("도시농부", style: MainPageTheme.title),
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
            child: Obx(()=>!loadingController.loading.value ? Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04,
                    0,
                    MediaQuery.of(context).size.width * 0.04,
                    0,
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
                              Row(
                                children: [
                                  Text(
                                    matchCategory[widget.keywords['category']]!,
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
                                      Get.off(()=> CommunityPageForm(category:widget.keywords['category']));
                                    },
                                  ),
                                ],
                              ),
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04,
                    0,
                    MediaQuery.of(context).size.width * 0.04,
                    0,
                  ),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.02,
                      left: MediaQuery.of(context).size.width * 0.02),
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
                              backgroundImage:profile!.image,
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
                                        child: Text(date,)
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Row(
                                            children: [
                                              const Text("조회 "),
                                              Text((int.parse(widget.keywords['views'].toString())+1).toString()),
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
                      Obx(()=>Html(data: readPostController.content.value)),
                      Container(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                                    //Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Obx(()=> commentListController.commentList.isEmpty? Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.08,
                          right:  MediaQuery.of(context).size.width * 0.06,
                        ),
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius:
                          MediaQuery.of(context).size.width * 0.07,
                          backgroundImage: profile!.image,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                          //Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                        },
                        child: const Text(
                          "첫 댓글을 입력하세요",
                          style: CommunityPageTheme.postFont,
                        ),
                      ),
                    ],
                  ),
                ) : InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                   // Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                  },
                  child: Column(children: commentListController.commentList
                    ,),
                ),)
              ],
            ):
            const Center(
                child: CircularProgressIndicator(
                  color: MainColor.three,
                )),),
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
                  onPressed: () {
                    Get.offAll(()=>CommunityPageForm(category: widget.before));
                  },
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
                        if(checkTimerController.time.value){
                          checkTimerController.stop(context);
                        }else{
                          if(!widget.keywords['deleteTnF']){
                            Map<String, String> _queryParameters =  <String, String>{
                              'postId': widget.keywords['id'].toString(),
                            };
                            final likeResponse = await http
                                .get(Uri.http(serverIP, '/api/islike',_queryParameters),
                                headers:{
                                  "Content-Type": "application/x-www-form-urlencoded",
                                  "Cookie":"JSESSIONID=$session",
                                }
                            );
                            if(likeResponse.statusCode ==200) {
                              readPostController.setIsLike(likeResponse.body);
                            }else{
                              readPostController.setIsLike("false");
                            }
                            var data = {
                              "postId":widget.keywords['id'],
                            };
                            var body = json.encode(data);
                            String work = "";
                            if(readPostController.isLike.isTrue){
                              work = "/deleteLike";
                              setState((){
                                likes = (int.parse(likes!)-1).toString();
                              });
                            }else{
                              work = "/createLike";
                              setState((){
                                likes = (int.parse(likes!)+1).toString();
                              });
                            }
                            await http.post(
                              Uri.http(serverIP, work),
                              headers: {
                                "Content-Type": "application/json",
                                "Cookie":"JSESSIONID=$session",
                              },
                              encoding: Encoding.getByName('utf-8'),
                              body: body,
                            );
                            readPostController.toggleLike();
                          }
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                        //Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before ,));
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