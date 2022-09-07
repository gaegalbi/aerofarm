import 'package:capstone/provider/Controller.dart';
import 'package:capstone/service/createComment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/Screen.dart';
import '../service/createAnswerComment.dart';
import '../themeData.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final TextEditingController textEditingController;
  const CustomBottomNavigationBar({Key? key, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifySelectController = Get.put(ModifySelectController());
    final routeController = Get.put(RouteController());
    late double keyboardOffset;

    if(GetPlatform.isIOS){
      keyboardOffset = -0.88;
    }else {
      keyboardOffset = -1.0;
    }

    return Obx(() => SizedBox(
      height: modifySelectController.modify.value ? 0 : GetPlatform.isIOS? 80 : 50,
      child: Transform.translate(
        offset: Offset(0.0, keyboardOffset * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          color: MainColor.three,
          child: Container(
            padding: const EdgeInsets.only(right: 15, left: 15,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: textEditingController,
                    textInputAction: TextInputAction.done,
                    style: LoginRegisterScreenTheme.text,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText:  routeController.current.value ==Screen.reply ?
                        "댓글을 남겨보세요":"답글을 남겨보세요",
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
                      onPressed: () {

                      },
                    ),
                    TextButton(
                        style: ButtonStyle(
                          padding:MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide.none,
                                )
                            ),
                            backgroundColor: MaterialStateProperty.all(MainColor.one)),
                        child: const Text(
                          "등록",
                          style: CommunityScreenTheme.bottomAppBarList,
                        ),
                        onPressed: () async {
                          if(routeController.current.value ==Screen.reply){
                            createComment(context, textEditingController, modifySelectController.board.value);
                          }else{
                            createAnswerComment(context,textEditingController,modifySelectController.comment.value,modifySelectController.board.value);
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
