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

import '../provider/Controller.dart';
import 'CommunityPageReadPost.dart';

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
  final modifyController = Get.put(ModifySelectController());
  double initial = 0.0;
  double distance = 0.0;
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

  Future<bool> _onWillPop() async {
    //textField 비활성
    modifyController.setUpFalse();
    replyDetailController.replyDetailBefore.value == "ReadPost" ?
    Get.off(()=>CommunityPageReadPost(index: replyDetailController.index.value,
        keywords: replyDetailController.keywords.value,
        before: replyDetailController.before.value)):
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
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
                        modifyController.setUpFalse();
                        selectController.clearId();
                        //Get.back을 쓰면
                        Get.back();
                       /* replyDetailController.replyDetailBefore.value =="ReadPost" ?
                        Get.back():
                        Get.off(()=>CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before));*/
                           // :   Get.back();//Navigator.pop(context);
                      },
                    )),
              ),
              title: const Text("답글쓰기", style: MainScreenTheme.title),
            ),
          /*  body: SingleChildScrollView(
              controller: _scrollController,
              child: Obx(()=>Column(
                children: replyDetailController.replyDetail[widget.keywords['groupId']] !=null
                    ?  replyDetailController.replyDetail[widget.keywords['groupId']]!
                : [
                  const Center(
                    child: CircularProgressIndicator(
                    color: MainColor.three,
                    ),
                  ),
                  ], //_replyList,
              ),),
            ),*/
            bottomNavigationBar: Obx(()=>SizedBox(
              height: modifyController.modify.value ? 0 : GetPlatform.isIOS? 80 : 50,
              child: Transform.translate(
                offset: Offset(0.0, keyboardOffset * MediaQuery.of(context).viewInsets.bottom),
                child: BottomAppBar(
                  color: MainColor.three,
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
                            style: LoginRegisterScreenTheme.text,
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "답글을 남겨보세요",
                                hintStyle: LoginRegisterScreenTheme.hint),
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
                                  style: CommunityScreenTheme.bottomAppBarList,
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
                                        "id":widget.keywords['id'],
                                        "postId": widget.keywords['postId'],
                                        "content": _textEditingController.text,
                                        "commentId" : widget.keywords['id']
                                      };
                                      var body = json.encode(data);
                                      await http.post(
                                        Uri.http(serverIP, '/createAnswerComment'),
                                        headers: {
                                          "Content-Type": "application/json",
                                          "Cookie": "JSESSIONID=$session",
                                        },
                                        encoding: Encoding.getByName('utf-8'),
                                        body: body,
                                      );
                                      readPostContent(widget.keywords['postId'], widget.keywords['category']);
                                      _textEditingController.text = "";
                                      replyDetailController.replyDetailBefore =="ReadPost" ?
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
              ),
            )
      ),),
      ),
    );
  }
}
