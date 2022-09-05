import 'package:capstone/model/BoardType.dart';
import 'package:capstone/service/fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../provider/Controller.dart';
import '../screen/CommunityReadPostScreen.dart';
import '../themeData.dart';

class BoardAnnouncementWidget extends StatelessWidget {
  final BoardType boardType;
  const BoardAnnouncementWidget({Key? key, required this.boardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingController = Get.put(LoadingController());
    final announceController = Get.put(AnnounceController());

    return boardType != BoardType.announcement ? Container(
      padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
          bottom: Get.height * 0.012),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.white),
          )),
      child: InkWell(
        onTap: () {
          if(announceController.board.value.title.isNotEmpty){
            loadingController.setTrue();
            readPostContent(announceController.board.value).then((value) => readComment(announceController.board.value.id, false).then((value) => Get.to(() => CommunityReadPostScreen(board: announceController.board.value,))));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.12,
              height: Get.width * 0.09,
              margin: EdgeInsets.only(right: Get.width * 0.015),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "필독",
                style: CommunityScreenTheme.announce,
              ),
            ),
            Obx(()=>Text(
              announceController.board.value.title.isNotEmpty ? announceController.board.value.title : "공지가 없습니다.",
              style: CommunityScreenTheme.announce,
            ),),
          ],
        ),
      ),
    ) : Container();
  }
}
