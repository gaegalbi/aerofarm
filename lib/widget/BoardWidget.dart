import 'package:capstone/model/BoardType.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../model/Board.dart';
import '../model/Screen.dart';
import '../screen/CommunityReadPostScreen.dart';
import '../service/normalFetch.dart';
import '../themeData.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  const BoardWidget({Key? key, required this.board}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final loadingController = Get.put(LoadingController());
    final routeController = Get.put(RouteController());
    final floatingController = Get.put(FloatingController());
    final modifySelectController = Get.put(ModifySelectController());

    return Container(
      height: MainSize.height * 0.08,
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.white),
          )),
      child: InkWell(
        onTap: () async {
          loadingController.setTrue();
          routeController.setCurrent(Screen.readPost);

          floatingController.setUp();
          modifySelectController.setBoard(board);
          readPostContent(board).then((value) => readComment(board.id, false)).then((value) => Navigator.of(loadingController.context).push(MaterialPageRoute(builder: (_) => CommunityReadPostScreen(board: board))));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MainSize.width * 0.8,
              margin: EdgeInsets.only(
                  right: MainSize.width * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MainSize.height * 0.008),
                    child: Row(
                      children: [
                        board.parentId.isEmpty || routeController.beforeBoardType.value == BoardType.hot?
                        Text(routeController.beforeBoardType.value == BoardType.hot || routeController.current.value == Screen.search ?
                        "[${board.category.displayName.substring(0,board.category.displayName.length-3)}] "
                            : "[${board.filter.displayName}] ",style: CommunityScreenTheme.filter,)
                        : Container(
                          padding: EdgeInsets.only(left: MainSize.width*0.01,right: MainSize.width*0.01),
                            child: Transform(child: const Icon(Icons.keyboard_return_outlined,color: MainColor.three,),alignment: Alignment.center, transform:Matrix4.rotationY(math.pi),)),
                        Text(
                          board.deleteTnF ? "삭제된 게시글 입니다.":board.title,
                          style: CommunityScreenTheme.main,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          board.writer,
                          overflow: TextOverflow.ellipsis,
                          style: CommunityScreenTheme.subEtc,
                        ),
                      ),
                      Flexible(
                        flex: board.date.length ==5 ? 4 : 7,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            board.date,
                            style: CommunityScreenTheme.subEtc,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "조회 ",
                              style: CommunityScreenTheme.subEtc,
                            ),
                            Text(
                              board.views.toString(),
                              style: CommunityScreenTheme.subEtc,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "추천 ",
                              style: CommunityScreenTheme.subEtc,
                            ),
                            Text(
                              board.likeCount.toString(),
                              style: CommunityScreenTheme.sub1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MainSize.width * 0.08,
              height: MainSize.height * 0.08,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      board.commentCount.toString(),
                      style: CommunityScreenTheme.subCommentCount,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "댓글",
                      style: CommunityScreenTheme.subEtc,
                      textAlign: TextAlign.center,
                    ),
                  ]),
              decoration: BoxDecoration(
                  color: MainColor.one,
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
