import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityReplyDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Board.dart';
import '../model/Comment.dart';
import '../model/Screen.dart';
import '../service/deleteComment.dart';
import '../themeData.dart';

class CommunityMenuWidget extends StatelessWidget {
  final Comment comment;
  const CommunityMenuWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifySelectController = Get.put(ModifySelectController());
    final routeController = Get.put(RouteController());

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child:TextButton(onPressed: (){
            modifySelectController.setSelect(comment.id);
            modifySelectController.setComment(comment);
            routeController.setCurrent(Screen.replyDetail);
            Get.back(); //menu 닫기
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyDetailScreen(comment: comment, board: modifySelectController.board.value,)));
            //Get.to(()=>CommunityPageReplyDetail(index: index, keywords: keywords, before: before,));
          }, child: const Text("댓글 답글쓰기",style: CommunityScreenTheme.commentMenuButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          color: MainColor.six,
          child:TextButton(onPressed: (){
            modifySelectController.setSelect(comment.id);
            modifySelectController.setId(comment.id);
            modifySelectController.setUpTrue();
            modifySelectController.setComment(comment);
            Get.back();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyDetailScreen(comment: comment, board: modifySelectController.board.value,)));
            //Get.to(()=>CommunityReplyDetailScreen(comment: comment, board: modifySelectController.board.value,));
          }, child: const Text("수정",style: CommunityScreenTheme.commentMenuButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child:TextButton(onPressed: () async {
            deleteComment(context,modifySelectController,comment);
          }, child: const Text("삭제",style: CommunityScreenTheme.commentMenuDeleteButton,)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: MainColor.six,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(onPressed: (){
            Get.back();
          }, child: const Text("취소",style: CommunityScreenTheme.commentMenuButton,)) ,
        )
      ],
    );
  }
}
