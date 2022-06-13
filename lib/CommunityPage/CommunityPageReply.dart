import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CommunityPageReadPost.dart';

class CommunityPageReply extends StatefulWidget {
  final List<Widget> commentList;
  final int index;
  final String id;
  final String writer;
  final String title;
  final String views;
  final String likes;
  final String comments;
  final String realDate;

  const CommunityPageReply({Key? key, required this.commentList, required this.index, required this.id, required this.writer, required this.title, required this.views, required this.likes, required this.comments, required this.realDate,}) : super(key: key);

  @override
  State<CommunityPageReply> createState() => _CommunityPageReplyState();
}

class _CommunityPageReplyState extends State<CommunityPageReply> {
  late bool sort;
  late TextEditingController _textEditingController;

  //late final List<Widget> _replyList = [];

  @override
  void initState() {
    //_replyList.clear();
    sort = true;
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //_replyList.clear();
    _textEditingController.dispose();
    super.dispose();
  }

/*  void addReply(String content, AssetImage image, String user) {
    widget.commentList.add(
        AddReply(content: content, image: image, user: user)
    );
  }*/

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
            toolbarHeight: MainSize.toobarHeight,
            elevation: 0,
            leadingWidth: MediaQuery
                .of(context)
                .size
                .width * 0.2106,
            leading: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
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
                      Get.offAll(() =>
                          CommunityPageReadPost(id: widget.id,
                            likes: widget.likes,
                            comments: widget.comments,
                            title: widget.title,
                            views: widget.views,
                            writer: widget.writer,
                            realDate: widget.realDate,
                            index: widget.index,));
                    },
                  )),
            ),
            title: const Text("도시농부", style: MainTheme.title),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.04,
                0,
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.04,
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.04,
              ),
              color: MainColor.six,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.02,
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.02),
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
                                        : CommunityPageTheme.postFalseFont)
                            ),
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
                                    style: sort ? CommunityPageTheme
                                        .postFalseFont : CommunityPageTheme
                                        .postFont)

                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: widget.commentList, //_replyList,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Transform.translate(
            offset:
            Offset(0.0, -0.9 * MediaQuery
                .of(context)
                .viewInsets
                .bottom),
            child: BottomAppBar(
              color: Colors.indigo,
              child: Container(
                padding: EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
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
                            onPressed: () {
                              setState(() {
                                /* addReply(_textEditingController.text, AssetImage("assets/images/profile.png"), "city");
                              _textEditingController.text = "";*/
                                _textEditingController.text = "";
                              });
                            }
                        )
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
