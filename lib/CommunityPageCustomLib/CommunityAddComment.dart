import 'dart:convert';

import 'package:capstone/CommunityPage/CommunityPageMyActivity.dart';
import 'package:capstone/CommunityPage/CommunityPageReplyDetail.dart';
import 'package:capstone/CommunityPageCustomLib/CommunityCommentMenu.dart';
import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPage/CommunityPageReply.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../provider/Controller.dart';
import '../themeData.dart';
import 'package:http/http.dart' as http;

import '../utils/CheckTimer.dart';

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
    final keyController = Get.put(KeyController());
    final nicknameController = Get.put(NicknameController());
    final selectController = Get.put(SelectReplyController());
    final modifyController = Get.put(ModifySelectController());
    final readPostController = Get.put(ReadPostController());
    final commentListController = Get.put(CommentListController());
    final TextEditingController textEditingController = TextEditingController();
    String date;
    before == "MyActivity" ? date = dateFormat.format(DateTime.parse(keywords['createdDate'])): date = dateInfoFormat.format(DateTime.parse(keywords['localDateTime']));
    textEditingController.text = keywords['content'];
    return before == "MyActivity" ?
    InkWell(
      onTap: (){
       /* readComment(keywords['postId'], "",false).then((value)=>{
        Navigator.of(keyController.scaffoldKey.currentContext!).push(MaterialPageRoute(
            builder: (_) => CommunityPageReply(index: 0, before: "MyActivity", keywords: {"id":keywords['postId']},)))
        });*/
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
        decoration:  const BoxDecoration(
            color: MainColor.six ,
            border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  keywords['content'],
                  style: CommunityScreenTheme.activityCommentContent,)),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
                child: Text(date,style: CommunityScreenTheme.activityCommentDate,)),
            Text(keywords['title'],style: CommunityScreenTheme.activityCommentTitle),
          ],
        ),
      ),
    )
      :Container(
    decoration:  BoxDecoration(
      color: before=='ReadPost' && selectController.id.value == keywords['id'] ? MainColor.sixChange :  MainColor.six ,
        border: const Border(bottom: BorderSide(width: 1, color: Colors.white))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
              left:  keywords['parentId'] == null ? MediaQuery.of(context).size.width * 0.08: MediaQuery.of(context).size.width * 0.18,
              //right:  MediaQuery.of(context).size.width * 0.06,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: keywords['parentId'] == null ? MediaQuery.of(context).size.width * 0.065 :  MediaQuery.of(context).size.width * 0.045,
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
                          style: keywords['writer'].length > 7 ? CommunityScreenTheme.commentWriterOver:CommunityScreenTheme.commentWriter,
                        ),
                        readPostController.writer.value == keywords['writer'] ?
                        Container(
                        margin: const EdgeInsets.only(left: 5),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: MainColor.three,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.account_circle),
                            Text("글쓴이",style: CommunityScreenTheme.commentOwner,),
                          ],
                        ),
                        )
                          :Container(),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        width: before!="ReadPost" ? MediaQuery.of(context).size.width*0.49 :MediaQuery.of(context).size.width*0.42,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child:Obx(()=> !(modifyController.modify.value && modifyController.id.value == keywords['id']) ?
                                RichText(maxLines: null,
                                 text:   keywords['deleteTnF'] ?
                                 const TextSpan(text:"삭제된 댓글입니다",style:CommunityScreenTheme.postFont)
                                     : keywords['parentId'] == null || commentListController.commentParentIdList.contains(keywords['parentId']) ?
                                 TextSpan(text:keywords['content'],style:CommunityScreenTheme.postFont )
                                     : TextSpan(
                                  children:[
                                      TextSpan(text:"@${keywords['parentNickname']} ",style: CommunityScreenTheme.postTagFont),
                                     TextSpan(text:keywords['content'], style: CommunityScreenTheme.postFont),
                                  ],
                                  style: CommunityScreenTheme.postFont),
                            )
                                    :TextField(
                                  controller: textEditingController,
                                ))),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.31,
                            child: Text(
                              date,
                              style: CommunityScreenTheme.commentDate,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              before !="ReadPost" && !keywords['deleteTnF'] ? TextButton(
                                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                onPressed: () {
                                  selectController.setId(keywords['id']);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReplyDetail(index: index, keywords: keywords, before: before,)));
                                  //Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
                                },
                                child: const Text(
                                  "답글 쓰기",
                                  style: CommunityScreenTheme.commentReply,
                                ),
                              ) : const SizedBox(),
                                  before =="ReadPost" && keywords['writer'] == nicknameController.nickname.value && !keywords['deleteTnF'] ? Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                          onPressed: () async {
                                            if(checkTimerController.time.value){
                                              checkTimerController.stop(context);
                                            }else{
                                              if(modifyController.id.value != keywords['id']){
                                                modifyController.setUpFalse();
                                              }
                                              modifyController.setId(keywords['id']);
                                              if(modifyController.modify.value && textEditingController.text.isEmpty){
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      Future.delayed(const Duration(milliseconds: 900), () {
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
                                                if(modifyController.modify.value){
                                                  var data = {
                                                    "id":keywords['id'],
                                                    "postId":keywords['postId'],
                                                    "content":textEditingController.text,
                                                    "commentId":keywords['id']
                                                  };
                                                  var body = json.encode(data);
                                                  await http.post(
                                                    Uri.http(serverIP, '/updateComment'),
                                                    headers: {
                                                      "Content-Type": "application/json",
                                                      "Cookie": "JSESSIONID=$session",
                                                    },
                                                    encoding: Encoding.getByName('utf-8'),
                                                    body: body,
                                                  );
                                                //  readComment(keywords['postId'],keywords['category'],false);
                                                }/*else{
                                                  textEditingController.text = keywords['content'];
                                                }*/
                                              }
                                              modifyController.changeModify();
                                            }
                                          },
                                          child:  Obx(()=>Text(
                                            !(modifyController.modify.value && modifyController.id.value==keywords['id']) ?
                                            "수정" : "등록", style: CommunityScreenTheme.commentModify,),),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                          onPressed: () async {
                                            if(checkTimerController.time.value){
                                                checkTimerController.stop(context);
                                            }else {
                                              if (modifyController.id.value != keywords['id']) {
                                                modifyController.changeModify();
                                              }
                                              if (modifyController.modify.value && modifyController.id.value == keywords['id']) {
                                                modifyController.modify.value = false;
                                              } else {
                                                var body = json.encode({"id": keywords['id']});
                                                await http.post(Uri.http(serverIP, '/deleteComment'),
                                                    headers: {
                                                      "Content-Type": "application/json",
                                                      "Cookie": "JSESSIONID=$session",
                                                    },
                                                    body: body
                                                );
                                               // readComment(keywords['postId'], keywords['category'],false);
                                              }
                                            }
                                          },
                                          child: Obx(()=>Text(
                                            !(modifyController.modify.value && modifyController.id.value==keywords['id']) ?
                                            "삭제" : "취소", style: CommunityScreenTheme.commentDelete,),
                                        ),),
                                      ),
                                    ],
                                  ):Container()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        !keywords['deleteTnF']&&before !="ReadPost" && keywords['writer'] == nicknameController.nickname.value ? TextButton(onPressed: (){
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return CommunityCommentMenu(index: index,keywords: keywords,before: before,);
              });
        },
            child: const Icon(Icons.more_horiz,color: MainColor.one,))
        : Container(),
      ],
    ),
  );
  }
}
