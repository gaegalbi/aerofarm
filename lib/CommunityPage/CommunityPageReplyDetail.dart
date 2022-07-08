import 'dart:convert';

import 'package:capstone/CommunityPage/CommunityPageReply.dart';
import 'package:capstone/main.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityAddComment.dart';
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../LoginPage/LoginPageLogin.dart';
import 'package:http/http.dart' as http;

class CommunityPageReplyDetail extends StatefulWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;

  const CommunityPageReplyDetail({
    Key? key,
    required this.index,
    required this.keywords,
    required this.before,
  }) : super(key: key);

  @override
  State<CommunityPageReplyDetail> createState() => _CommunityPageReplyDetailState();
}

class _CommunityPageReplyDetailState extends State<CommunityPageReplyDetail> {
  late bool sort;
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  final commentListController = Get.put(CommentListController());
  final pageIndexController = Get.put(PageIndexController());
  final selectController = Get.put(SelectReplyController());
  final replyDetailController = Get.put(ReplyDetailListController());
  late double keyboardOffset;

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      pageIndexController.increment();
      loadFetch(widget.keywords['category']);
    }
  }

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      selectController.clearId();
                      replyDetailController.before =="ReadPost" ?
                      Get.off(()=>CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before))
                          : Get.back();
                    },
                  )),
            ),
            title: const Text("답글쓰기", style: MainPageTheme.title),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              color: MainColor.six,
              child: Obx(()=>Column(
                children: replyDetailController.replyDetail[widget.keywords['commentGroupId']]!, //_replyList,
              ),)
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
                            hintText: "답글을 남겨보세요",
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
                                        Future.delayed(const Duration(milliseconds: 900), () {Navigator.pop(context);});
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
                                    "commentId" : widget.keywords['commentId']
                                  };
                                  var body = json.encode(data);
                                  await http.post(
                                    Uri.http(ipv4, '/createAnswerComment'),
                                    headers: {
                                      "Content-Type": "application/json",
                                      "Cookie": "JSESSIONID=$session",
                                    },
                                    encoding: Encoding.getByName('utf-8'),
                                    body: body,
                                  );
                                  readPostContent(widget.keywords['id'], widget.keywords['category']);
                                  _textEditingController.text = "";
                                  replyDetailController.before =="ReadPost" ?
                                  Get.off(()=>CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before))
                                      : Get.back();
                                }
                              }
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
