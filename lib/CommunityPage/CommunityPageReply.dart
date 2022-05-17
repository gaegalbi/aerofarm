import 'package:capstone/CommunityPage/CommunityPageReadPost.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CurrentTime.dart';

class CommunityPageReply extends StatefulWidget {
  const CommunityPageReply({Key? key}) : super(key: key);

  @override
  State<CommunityPageReply> createState() => _CommunityPageReplyState();
}

class _CommunityPageReplyState extends State<CommunityPageReply> {
  bool post = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: MainColor.six,
            toolbarHeight: MainSize.toobarHeight,
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
                  Get.offAll(() => const CommunityPageReadPost());
                },
              )),
            ),
            title: const Text("도시농부", style: MainTheme.title),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04,
              ),
              color: MainColor.six,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.02,
                            left: MediaQuery.of(context).size.width * 0.02),
                        /* decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 2, color: Colors.white),
                        )),*/
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (!post) post = !post;
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero)),
                              child: post
                                  ? const Text("등록순", style: Community.postFont)
                                  : const Text("등록순",
                                      style: Community.postFalseFont),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (post) post = !post;
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero)),
                              child: post
                                  ? const Text("최신순",
                                      style: Community.postFalseFont)
                                  : const Text("최신순",
                                      style: Community.postFont),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(width: 2, color: Colors.white),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: const Text(
                                                    "city",
                                                    style: Community.postFont,
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text("도시농부 서비스 너무 좋네요",
                                                style: Community.postFont),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child:   const CurrentTime(
                                                    type: true, style: 'contentInfo',
                                                  ),),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child:   const CurrentTime(
                                                    type: false, style: 'contentInfo',
                                                  ),),
                                              SizedBox(
                                                height: 20,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                                                    ),
                                                    onPressed: () {  },
                                                    child: Text(
                                                      "답글 쓰기",
                                                      style:
                                                          Community.contentInfo,
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
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
          ),
          bottomNavigationBar: Transform.translate(
            offset:
                Offset(0.0, -0.9 * MediaQuery.of(context).viewInsets.bottom),
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const TextField(
//controller: _lUserNameController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "댓글을 남겨보세요",
                            hintStyle: LrTheme.hint),
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
                          onPressed: () {
                            Get.to(() => const CommunityPageReply());
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(MainColor.one)),
                          child: Text(
                            "등록",
                            style: Community.bottomAppBarList,
                          ),
                          onPressed: () {
                            Get.to(() => const CommunityPageReply());
                          },
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
