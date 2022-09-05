import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityReadPostScreen.dart';
import 'package:capstone/screen/CommunityReplyScreen.dart';
import 'package:capstone/widget/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/fetch.dart' as fetch;
import '../model/Board.dart';
import '../model/Comment.dart';
import '../model/Screen.dart';
import '../service/createAnswerComment.dart';
import '../themeData.dart';

class CommunityReplyDetailScreen extends StatelessWidget {
  final Board board;
  final Comment comment;
  const CommunityReplyDetailScreen({Key? key, required this.comment, required this.board}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifySelectController = Get.put(ModifySelectController());
    final replyDetailController = Get.put(ReplyDetailListController());
    final routeController = Get.put(RouteController());
    final loadingController = Get.put(LoadingController());
    final _textEditingController = TextEditingController();

    Future<bool> _onWillPop() async {
      //textField 비활성
      modifySelectController.setUpFalse();
      if(routeController.before.value == Screen.readPost){
        routeController.setCurrent(Screen.readPost);
        loadingController.setTrue();
        fetch.readPostContent(board).then((value) => fetch.readComment(board.id, false)).then((value) =>Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board))));
      }else{
        routeController.setCurrent(Screen.reply);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyScreen(board: board)));
      }
      //replyDetailController.replyDetailBefore.value == "ReadPost" ?
      return false;
    }

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
                      modifySelectController.setUpFalse();
                      modifySelectController.clearId();

                      if(routeController.before.value == Screen.readPost){
                        routeController.setCurrent(Screen.readPost);
                        Get.off(()=>CommunityReadPostScreen(board:board));
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyScreen(board: board)));
                      }


                        //routeController.setCurrent(Screen.reply);

                      //Get.back();
                      /* replyDetailController.replyDetailBefore.value =="ReadPost" ?
                        Get.back():
                        Get.off(()=>CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before));*/
                      // :   Get.back();//Navigator.pop(context);
                    },
                  )),
            ),
            title: const Text("답글쓰기", style: MainScreenTheme.title),
          ),
            body: SingleChildScrollView(
              child: Obx(()=>Column(
                children: replyDetailController.replyDetail[comment.groupId] !=null
                    ?  replyDetailController.replyDetail[comment.groupId]!
                : [
                  const Center(
                    child: CircularProgressIndicator(
                    color: MainColor.three,
                    ),
                  ),
                  ], //_replyList,
              ),),
            ),
          bottomNavigationBar: CustomBottomNavigationBar(textEditingController: _textEditingController,),),
      ),
    );
  }
}
