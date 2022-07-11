import 'package:capstone/CommunityPage/CommunityPageReplyDetail.dart';
import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';

class SelectReplyController extends GetxController{
  final id = 0.obs;

  void setId(int select){
    id.value = select;
  }
  void clearId(){
    id.value = 0;
  }
}

class AddComment extends StatelessWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;
  final String selectReply;

  const AddComment(
      {Key? key,
      required this.index,
      required this.keywords,
      required this.before, required this.selectReply})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nicknameController = Get.put(NicknameController());
    final selectController = Get.put(SelectReplyController());
    final readPostController = Get.put(ReadPostController());
    String date = dateInfoFormat.format(DateTime.parse(keywords['localDateTime']));

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.02,
          left:  keywords['parentId'] == null ? MediaQuery.of(context).size.width * 0.08: MediaQuery.of(context).size.width * 0.18,
          right:  MediaQuery.of(context).size.width * 0.06,
      ),
      decoration:  BoxDecoration(
        color: before=='ReadPost' && selectController.id.value == keywords['id'] ? MainColor.sixChange :  MainColor.six ,
          border: const Border(bottom: BorderSide(width: 1, color: Colors.white))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: keywords['parentId'] == null ? MediaQuery.of(context).size.width * 0.07 :  MediaQuery.of(context).size.width * 0.05,
              backgroundImage: profile!.image,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    keywords['writer'],
                    style: keywords['writer'].length > 7 ? CommunityPageTheme.commentWriterOver:CommunityPageTheme.commentWriter,
                  ),
                  readPostController.writer.value == keywords['writer'] ?
                  Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: MainColor.three,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.account_circle),
                      Text("글쓴이",style: CommunityPageTheme.commentOwner,),
                    ],
                  ),
                  )
                    :Container(),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: before!="ReadPost" ? MediaQuery.of(context).size.width*0.49 :MediaQuery.of(context).size.width*0.42,
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
                width: before!="ReadPost" ? MediaQuery.of(context).size.width*0.49 :MediaQuery.of(context).size.width*0.42,
                height: MediaQuery.of(context).size.height * 0.025,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.31,
                      child: Text(
                        date,
                        style: CommunityPageTheme.commentDate,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          before !="ReadPost" ? TextButton(
                            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                            onPressed: () {
                              selectController.setId(keywords['id']);
                              Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
                            },
                            child: const Text(
                              "답글 쓰기",
                              style: CommunityPageTheme.commentReply,
                            ),
                          ) : const SizedBox(),
                              before =="ReadPost" && keywords['writer'] == nicknameController.nickname.value? SizedBox(
                              width: MediaQuery.of(context).size.width*0.1,
                              height: MediaQuery.of(context).size.height * 0.025,
                              child: TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                onPressed: () {},
                                child: const Text("삭제", style: CommunityPageTheme.commentDelete,),
                              )):Container()
                        ],
                      ),
                    ),
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
