import 'package:capstone/CommunityPageCustomLib/CommunityCommentMenu.dart';
import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/service/getActivityBoardFetch.dart';
import 'package:capstone/service/deleteComment.dart';
import 'package:capstone/widget/CommunityMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/Board.dart';
import '../model/Comment.dart';
import '../model/Screen.dart';
import '../screen/CommunityReplyDetailScreen.dart';
import '../service/modifyComment.dart';
import '../themeData.dart';
import '../service/fetch.dart' as fetch;

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readPostController = Get.put(ReadPostController());
    final modifySelectController = Get.put(ModifySelectController());
    final userController = Get.put(UserController());
    final routeController = Get.put(RouteController());
    final TextEditingController textEditingController = TextEditingController();

    return routeController.current.value != Screen.activity ? Container(
      decoration:  const BoxDecoration(
          color: MainColor.six ,
          border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: MainSize.height * 0.02,
                bottom: MainSize.height * 0.02,
                left:  comment.parentId == "null" ? MainSize.width * 0.08: MainSize.width * 0.18,
                //right:  MediaQuery.of(context).size.width * 0.06,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: comment.parentId == "null" ? MainSize.width * 0.065 :  MainSize.width * 0.045,
                      backgroundImage: comment.picture?.image,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.writer,
                            style: comment.writer.length > 7 ? CommunityScreenTheme.commentWriterOver:CommunityScreenTheme.commentWriter,
                          ),
                          readPostController.writer.value == comment.writer ?
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
                          width:  MainSize.width*0.49, //:MediaQuery.of(context).size.width*0.42,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  child:Obx(()=> !(modifySelectController.modify.value && modifySelectController.id.value == comment.id) ?
                                  RichText(maxLines: null,
                                    text: comment.deleteTnF ?
                                    const TextSpan(text:"삭제된 댓글입니다",style:CommunityScreenTheme.postFont)
                                        : comment.parentId== "null" ?//|| commentListController.commentParentIdList.contains(keywords['parentId']) ?
                                    TextSpan(text: comment.content,style:CommunityScreenTheme.postFont )
                                        : TextSpan(
                                        children:[
                                          TextSpan(text:"@${comment.parentNickname} ",style: CommunityScreenTheme.postTagFont),
                                          TextSpan(text:comment.content, style: CommunityScreenTheme.postFont),
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
                                comment.date,
                                style: CommunityScreenTheme.commentDate,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               // before !="ReadPost" && !keywords['deleteTnF'] ?
                                routeController.current.value != Screen.replyDetail && !comment.deleteTnF ?
                                TextButton(
                                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                  onPressed: () async {
                                    //selectController.setId(keywords['id']);
                                    routeController.setCurrent(Screen.replyDetail);
                                    modifySelectController.setComment(comment);
                                     Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyDetailScreen(comment: comment, board: modifySelectController.board.value,)));
                                    //Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
                                  },
                                  child: const Text(
                                    "답글 쓰기",
                                    style: CommunityScreenTheme.commentReply,
                                  ),
                                ) : const SizedBox(),
                               // before =="ReadPost" && keywords['writer'] == nicknameController.nickname.value && !keywords['deleteTnF'] ?
                                routeController.current.value == Screen.replyDetail && comment.writer == userController.user.value.nickname &&!comment.deleteTnF ?
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                        onPressed: () async {
                                            modifyComment(context,modifySelectController,comment,textEditingController);
                                        },
                                        child: Obx(()=>Text(
                                          !(modifySelectController.modify.value && modifySelectController.id.value==comment.id) ?
                                          "수정" : "등록", style: CommunityScreenTheme.commentModify,),),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                        onPressed: () async {
                                            deleteComment(context,modifySelectController,comment);
                                        },
                                        child: Obx(()=>Text(
                                          !(modifySelectController.modify.value && modifySelectController.id.value==comment.id) ?
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
          //!keywords['deleteTnF']&&before !="ReadPost" && keywords['writer'] == nicknameController.nickname.value ? TextButton(onPressed: (){
          routeController.current.value != Screen.replyDetail && !comment.deleteTnF  && comment.writer == userController.user.value.nickname ? TextButton(onPressed: (){
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                 // return CommunityCommentMenu(index: index,keywords: keywords,before: before,);
                  return CommunityMenuWidget(comment: comment);
                });
          },
              child: const Icon(Icons.more_horiz,color: MainColor.one,))
              : Container(),
        ],
      ),
    ) :  InkWell(
      onTap: (){
      /* //  readComment(keywords['postId'], "",false).then((value)=>{
        Navigator.of(keyController.scaffoldKey.currentContext!).push(MaterialPageRoute(
            builder: (_) => CommunityPageReply(index: 0, before: "MyActivity", keywords: {"id":keywords['postId']},)));
        //});*/
        getActivityBoardFetch(comment.postId);
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
                margin: EdgeInsets.only(bottom: MainSize.height*0.02),
                child: Text(
                  comment.content,
                  style: CommunityScreenTheme.activityCommentContent,)),
            Container(
                margin: EdgeInsets.only(bottom: MainSize.height*0.01),
                child: Text(comment.date,style: CommunityScreenTheme.activityCommentDate,)),
            Text(comment.title,style: CommunityScreenTheme.activityCommentTitle),
          ],
        ),
      ),
    );
  }
}
