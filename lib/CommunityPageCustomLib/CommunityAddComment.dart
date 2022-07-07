import 'package:capstone/CommunityPage/CommunityPageReplyDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';

class AddComment extends StatelessWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;

  const AddComment(
      {Key? key,
      required this.index,
      required this.keywords,
      required this.before})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nicknameController = Get.put(NicknameController());
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.02),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: keywords['commentGroupId'] == keywords['commentId'] ? MediaQuery.of(context).size.width * 0.09 : MediaQuery.of(context).size.width * 0.08,
              backgroundImage: profile!.image,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                keywords['writer'],
                style: CommunityPageTheme.commentWriter,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: RichText(
                        maxLines: null,
                        text: TextSpan(
                            text: keywords['content'],
                            style: CommunityPageTheme.postFont),
                      )),
                    ],
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.65,
                height: MediaQuery.of(context).size.height * 0.025,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        keywords['date'],
                        style: CommunityPageTheme.commentDate,
                      ),
                    ),
                    before !="ReadPost" ? Expanded(
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.03),
                              child: TextButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all(EdgeInsets.zero)),
                                onPressed: () {
                                  print(keywords['commentGroupId']);
                                  Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before));
                                },
                                child: const Text(
                                  "답글 쓰기",
                                  style: CommunityPageTheme.commentReply,
                                ),
                              )),
                          keywords['writer'] == nicknameController.nickname.value ? SizedBox(
                              width: MediaQuery.of(context).size.width*0.1,
                              height: MediaQuery.of(context).size.height * 0.025,
                              child: TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                onPressed: () {},
                                child: const Text(
                                  "삭제",
                                  style: CommunityPageTheme.commentDelete,
                                ),
                              )):Container()
                        ],
                      ),
                    ):Container(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
