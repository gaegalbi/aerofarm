import 'package:capstone/screen/CommunityActivityScreen.dart';
import 'package:capstone/screen/CommunityReplyScreen.dart';
import 'package:capstone/screen/CommunitySearchResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../service/normalFetch.dart' as fetch;
import '../model/Board.dart';
import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../themeData.dart';
import '../widget/ReadPostBottomAppBarButton.dart';
import '../widget/CustomAppBar.dart';
import '../widget/FloatingWidget.dart';
import 'CommunityScreen.dart';

class CommunityReadPostScreen extends StatelessWidget {
  final Board board;

  const CommunityReadPostScreen({Key? key, required this.board})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final floatingController = Get.put(FloatingController());
    final loadingController = Get.put(LoadingController());
    final userController = Get.put(UserController());
    final commentListController = Get.put(CommentListController());
    final routeController = Get.put(RouteController());
    final modifySelectController = Get.put(ModifySelectController());
    final tabController = Get.put(CustomTabController());
    final searchController = Get.put(SearchController());

    Future<bool> _onWillPop() async {
      //textField 비활성
      modifySelectController.setUpFalse();
      if(routeController.before.value == Screen.activity || routeController.isMain.value){
        routeController.setCurrent(Screen.activity);
        tabController.setTab();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>const CommunityActivityScreen()));
      }else if(routeController.isSearch.value){
        routeController.setCurrent(Screen.search);
        routeController.isSearch.value = false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>CommunitySearchResultScreen(search: searchController.getSearch(), keyword: '',)));
      }
      else {
        routeController.setCurrent(Screen.community);
        Get.offAll(() => CommunityScreen(boardType: routeController.beforeBoardType.value));
      }
        //Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyScreen(board: board)));
      //replyDetailController.replyDetailBefore.value == "ReadPost" ?
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onDoubleTap: () {
          floatingController.toggle();
        },
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: Obx(() => floatingController.floating.value
                ? const FloatingWidget(type: Screen.community)
                : const SizedBox()),
            backgroundColor: MainColor.six,
            appBar: CustomAppBar(
              title: "도시농부",
              onPressed: () async {
                if(routeController.before.value == Screen.activity || routeController.isMain.value){
                  routeController.setCurrent(Screen.activity);
                  tabController.setTab();
                  Get.off(()=>const CommunityActivityScreen());
                }else if(routeController.before.value == Screen.search){
                  routeController.setCurrent(Screen.search);
                  Get.offAll(() => CommunitySearchResultScreen(search: searchController.getSearch(), keyword: '',));
                }else{
                  loadingController.setTrue();
                  routeController.setCurrent(Screen.community);
                  Get.offAll(()=> CommunityScreen(boardType: routeController.beforeBoardType.value));
                }
              },
              iconData: Icons.chevron_left,
              home: true,
            ),
            body: Obx(()=>!loadingController.loading.value ?
                RefreshIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  onRefresh: () async {
                    fetch.readPostContent(board);
                    fetch.readComment(board.id, false);
                  },
                  child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MainSize.height,
                        ),
                        child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.04,
                                  0,
                                  MediaQuery.of(context).size.width * 0.04,
                                  0,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        width: MediaQuery.of(context).size.width,
                                        height: MainSize.height * 0.03,
                                        margin: EdgeInsets.only(
                                            bottom: MainSize.height* 0.005),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  board.category.displayName,
                                                  style: CommunityScreenTheme.title,
                                                ),
                                                IconButton(
                                                  splashRadius: 20,
                                                  padding: EdgeInsets.zero,
                                                  alignment: Alignment.center,
                                                  color: MainColor.three,
                                                  constraints: const BoxConstraints(),
                                                  icon: const Icon(
                                                    Icons.chevron_right,
                                                  ),
                                                  onPressed: () {
                                                    Get.off(() => CommunityScreen(boardType: board.category,));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context).size.width *
                                              0.05,
                                          bottom: MediaQuery.of(context).size.height *
                                              0.012),
                                      child: Text(
                                        board.title,
                                        style: CommunityScreenTheme.postTitle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //게시글 부분
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
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height *
                                              0.01),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom:
                                            BorderSide(width: 2, color: Colors.white),
                                      )),
                                      child: Row(
                                        children: [
                                          //프로필
                                          CircleAvatar(
                                            radius:
                                                MediaQuery.of(context).size.width *
                                                    0.08,
                                            backgroundImage: userController
                                                .user.value.picture?.image,
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
                                                            right: 20),
                                                        child: Text(
                                                          board.writer,
                                                          style: CommunityScreenTheme
                                                              .commentWriter,
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets.only(
                                                            right: 10),
                                                        child: Text(board.date)),
                                                    Container(
                                                        margin: const EdgeInsets.only(
                                                            right: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text("조회 "),
                                                            Text((board.views+1).toString()),
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    board.deleteTnF ? Container(
                                      alignment: Alignment.center,
                                        height: MainSize.height * 0.2,
                                        child: const Text("삭제 처리된 게시물입니다.",style: CommunityScreenTheme.deleteTnFTrue,)) : Html(data: board.content),
                                    Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              width: 2, color: Colors.white),
                                        )),
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height *
                                                0.01),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty.all(
                                                      EdgeInsets.zero)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 5),
                                                    child: const Text(
                                                      "댓글",
                                                      style:
                                                          CommunityScreenTheme.postFont,
                                                    ),
                                                  ),
                                                  Text(
                                                    routeController.commentCount.value.toString(),
                                                    //widget.keywords['commentCount'].toString(),
                                                    style:
                                                        CommunityScreenTheme.postFont,
                                                  ),
                                                  const Icon(
                                                    Icons.chevron_right,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                routeController.setCurrent(Screen.reply);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            CommunityReplyScreen(
                                                                board: board)));
                                                //Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                                                //Get.to(() => CommunityPageReply(index: widget.index,keywords: widget.keywords, before: widget.before,));
                                              },
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              //댓글 부분
                              Obx(() => routeController.commentCount.value == 0
                                    ? InkWell(
                                  onTap: (){
                                    routeController.setCurrent(Screen.reply);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CommunityReplyScreen(
                                                    board: board)));
                                  },
                                      child: Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height * 0.02,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height * 0.02,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width * 0.08,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width * 0.06,
                                                ),
                                                margin:
                                                    const EdgeInsets.only(right: 10),
                                                child: CircleAvatar(
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                  backgroundImage: userController
                                                      .user.value.picture?.image,
                                                ),
                                              ),
                                              const Text(
                                                  "첫 댓글을 입력하세요",
                                                  style: CommunityScreenTheme.postFont,
                                                ),
                                            ],
                                          ),
                                        ),
                                    )
                                    : InkWell(
                                        onTap: () {
                                          routeController.setCurrent(Screen.reply);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CommunityReplyScreen(
                                                          board: board)));
                                        },
                                        child: Column(
                                          children: commentListController.commentList,
                                        )),
                              ),
                              commentListController.commentList.length > 10
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10, bottom: 10),
                                      child: TextButton(
                                        onPressed: () {
                                          routeController.setCurrent(Screen.reply);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CommunityReplyScreen(
                                                          board: board)));
                                          //Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityPageReply(index: widget.index, keywords: widget.keywords, before: widget.before,)));
                                        },
                                        child: const Text(
                                          "댓글더보기",
                                          style: CommunityScreenTheme.title,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                      ),
                    ),
                )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: MainColor.three,
                      )),
                    ),
            ),
            bottomNavigationBar: CustomBottomAppBar(board: board,routeController: routeController,userController: userController,)),
      ),
    );
  }
}
