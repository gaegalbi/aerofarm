import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityReadPostScreen.dart';
import 'package:capstone/widget/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/normalFetch.dart' as fetch;

import '../model/Board.dart';
import '../model/Screen.dart';
import '../service/normalFetch.dart';
import '../themeData.dart';

class CommunityReplyScreen extends StatelessWidget {
  final Board board;
  const CommunityReplyScreen({Key? key, required this.board}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentListController = Get.put(CommentListController());
    final routeController = Get.put(RouteController());
    final _textEditingController = TextEditingController();

    commentListController.setUpSort();

    Future<bool> _onWillPop() async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board)));
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
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
                         routeController.setCurrent(Screen.readPost);
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board)));
                        //}
                      },
                    )),
              ),
              title: const Text("도시농부", style: MainScreenTheme.title),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                fetch.readPostContent(board);
                fetch.readComment(board.id, false);
              },
              backgroundColor: Colors.black,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  color: MainColor.six,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.04,
                              0,
                              MediaQuery.of(context).size.width * 0.04,
                              0,
                            ),
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02),
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2, color: Colors.white),
                                )),
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      if(commentListController.sort.value){
                                        commentListController.toggleSort();
                                        fetch.readPostContent(board);
                                        readComment(board.id,false);
                                      }
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)),
                                    child: Obx(()=>Text("최신순",
                                        style: !commentListController.sort.value
                                          ? CommunityScreenTheme.replyButtonFont
                                          :CommunityScreenTheme.replyButtonFalseFont))),
                                TextButton(
                                    onPressed: () {
                                      if(!commentListController.sort.value){
                                        commentListController.toggleSort();
                                        fetch.readPostContent(board);
                                        readReverseComment(board.id,false);
                                      }
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)),
                                    child: Obx(()=>Text("등록순",
                                        style: commentListController.sort.value
                                            ? CommunityScreenTheme.replyButtonFont
                                        :CommunityScreenTheme.replyButtonFalseFont
                                    ),)),
                              ],
                            ),
                          ),
                          Obx(()=>Column(
                            children: commentListController.commentList, //_replyList,
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(textEditingController: _textEditingController,)),
      ),
    );
  }
}
/*

Transform.translate(
              offset: Offset(0.0, keyboardOffset * MediaQuery.of(context).viewInsets.bottom),
              child: BottomAppBar(
                color: Colors.indigo,
                child: Container(
                  padding: const EdgeInsets.only(right: 15, left: 15,),
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
                              hintText: "댓글을 남겨보세요",
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
                                style: CommunityPageTheme.bottomAppBarList,
                              ),
                              onPressed: () async {
                                  createComment(context, _textEditingController,modifySelectController.board.value);
                              }
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
 */