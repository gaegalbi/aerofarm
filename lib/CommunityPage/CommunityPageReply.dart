import 'dart:convert';

import 'package:capstone/CommunityPage/CommunityPageMyActivity.dart';
import 'package:capstone/main.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../LoginPage/LoginPageLogin.dart';
import 'package:http/http.dart' as http;

import 'CommunityPageReadPost.dart';

class CommunityPageReply extends StatefulWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;

  const CommunityPageReply({
    Key? key,
    required this.index,
    required this.keywords,
    required this.before,
  }) : super(key: key);

  @override
  State<CommunityPageReply> createState() => _CommunityPageReplyState();
}

class _CommunityPageReplyState extends State<CommunityPageReply>{
  late bool sort;
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final replyDetailController = Get.put(ReplyDetailListController());
  late double keyboardOffset;

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      pageIndexController.increment();
      //fetch();
      //print(widget.keywords);
      loadFetch(widget.keywords['category']);
     // fetch(widget.keywords['communityCategory'],true);
    }
  }

  @override
  void initState() {
    print(widget.keywords);
    if(GetPlatform.isIOS){
      keyboardOffset = -0.9;
    }else {
      keyboardOffset = -1.0;
    }
    sort = true;
    pageIndexController.setUp();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    replyDetailController.replyDetailSetUpBefore("Reply");
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if(widget.before == "MyActivity"){
      activityCommentStartFetch();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity()));
    }else{
      Get.off(()=>CommunityPageReadPost(index: replyDetailController.index.value,
          keywords: replyDetailController.keywords.value,
          before: replyDetailController.before.value));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      //shouldAddCallback: true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: MainColor.six,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: MainColor.six,
              toolbarHeight: MainSize.toolbarHeight,
              elevation: 0,
              leadingWidth: MediaQuery.of(context).size.width * 0.2106,
              leading: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
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
                    if(widget.before=="MyActivity"){
                      activityCommentStartFetch().then((value)=>  Get.off(()=>const CommunityPageMyActivity()));
                    } else{
                      Get.back();
                    }
                  },
                )),
              ),
              title: const Text("도시농부", style: MainPageTheme.title),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                color: MainColor.six,
                child: Column(
                  children: [
                    Column(
                      children: [
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
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (!sort) sort = !sort;
                                    });
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero)),
                                  child: Text("등록순",
                                      style: sort
                                          ? CommunityPageTheme.postFont
                                          : CommunityPageTheme.postFalseFont)),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (sort) sort = !sort;
                                    });
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero)),
                                  child: Text("최신순",
                                      style: sort
                                          ? CommunityPageTheme.postFalseFont
                                          : CommunityPageTheme.postFont)),
                            ],
                          ),
                        ),
                        Obx(()=>Column(
                          children: commentListController.commentList, //_replyList,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Transform.translate(
              offset:
                  Offset(0.0, keyboardOffset * MediaQuery.of(context).viewInsets.bottom),
              child: BottomAppBar(
                color: Colors.indigo,
                child: Container(
                  padding: EdgeInsets.only(right: 15, left: 15,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          controller: _textEditingController,
                          textInputAction: TextInputAction.next,
                          style: LoginRegisterPageTheme.text,
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "댓글을 남겨보세요",
                              hintStyle: LoginRegisterPageTheme.hint),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                            ),
                            onPressed: () {},
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(MainColor.one)),
                              child: const Text(
                                "등록",
                                style: CommunityPageTheme.bottomAppBarList,
                              ),
                              onPressed: () async {
                                if(checkTimerController.time.value){
                                  checkTimerController.stop(context);
                                }else{
                                  if(_textEditingController.text==""){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(const Duration(milliseconds: 900),
                                                  () {
                                                Navigator.pop(context);
                                              });
                                          return const AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            contentPadding: EdgeInsets.all(5),
                                            content: Text(
                                              "댓글 내용이\n있어야합니다.",
                                              style: TextStyle(fontSize: 28),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        });
                                  }else{
                                    var data = {
                                      "postId": widget.keywords['id'],
                                      "content": _textEditingController.text,
                                    };
                                    var body = json.encode(data);
                                    await http.post(
                                      Uri.http(serverIP, '/createComment'),
                                      headers: {
                                        "Content-Type": "application/json",
                                        "Cookie": "JSESSIONID=$session",
                                      },
                                      encoding: Encoding.getByName('utf-8'),
                                      body: body,
                                    );
                                    }
                                  if(widget.before=="MyActivity"){
                                    readComment(widget.keywords['id'], "");
                                  }else{
                                    readPostContent(widget.keywords['id'], widget.keywords['category']); 
                                  }
                                    _textEditingController.text = "";
                                  }
                               }
                              )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
