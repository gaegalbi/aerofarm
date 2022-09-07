import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityScreen.dart';
import 'package:capstone/service/createAnswerPost.dart';
import 'package:capstone/widget/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../model/Screen.dart';
import '../service/createPost.dart';
import '../themeData.dart';
import '../widget/RadioButton.dart';

class CommunityCreatePostScreen extends StatelessWidget {
  final Screen current;
  const CommunityCreatePostScreen({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeController = Get.put(RouteController());
    final postController = Get.put(PostController());
    final loadingController = Get.put(LoadingController());

    const double contentPadding = 30;

    double contentCheckKeyBoard() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        return MediaQuery.of(context).viewInsets.bottom;
      } else {
        return 0;
      }
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      if (current == Screen.updatePost && postController.isOnce.value) {
        postController.controller.value.setText(routeController.board.value.content);
        postController.titleController.value.text = routeController.board.value.title;
        loadingController.setFalse();
        postController.isOnce.value = false;
      }
      if(current == Screen.readPost && postController.isOnce.value){
        postController.titleController.value.text = "re : " + routeController.board.value.title;
        loadingController.setFalse();
        postController.isOnce.value = false;
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MainSize.toolbarHeight / 2,
        elevation: 0,
        backgroundColor: MainColor.six,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            postController.controller.value.editorController?.clearFocus();
            postController.controller.value.disable();
            loadingController.setFalse();
            postController.isOnce.value = true;
            Future.delayed(const Duration(microseconds: 1), () {
              (current == Screen.updatePost || current == Screen.readPost) ? Get.back() : Get.offAll(() =>CommunityScreen(boardType: routeController.beforeBoardType.value));
            });
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: MainColor.three,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
                onPressed: () async {
                  if (current == Screen.readPost) {
                    //답글 쓰기
                    createAnswerPost(context, postController.controller.value, postController.titleController.value);
                  }
                  else {
                    //그냥 글쓰기
                    createPost(context,current,postController.titleController.value,postController.controller.value);
                  }
                },
                child: const Text(
                  "등록",
                  style: CommunityScreenTheme.postFont,
                )),
          )
        ],
      ),
      body: Stack(
        children: [
           Container(
          color: MainColor.six,
          child: CustomScrollView(
            slivers: [
              (current == Screen.updatePost || current == Screen.readPost)
                  ? SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: MainSize.width * 0.8,
                      decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                      child: Obx(()=>TextField(
                          focusNode: postController.focusNode.value,//titleFocus,
                          controller: postController.titleController.value,//_titleController,
                          style: const TextStyle(
                            fontFamily: "bmPro",
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            //hintText: "Re : " + widget.keywords['title'],
                            hintStyle: TextStyle(
                                fontFamily: "bmPro",
                                fontSize: 25,
                                color: Colors.grey),
                          )),),
                    ),
                  ],
                ),
              )
                  : SliverToBoxAdapter(
                child: Column(
                  children: [
                    Builder(
                        builder: (context) => TextButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            overlayColor: null,
                          ),
                          child: Container(
                            width: MainSize.width * 0.8,
                            padding: EdgeInsets.only(bottom: MainSize.height * 0.006),
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white),
                                )),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(()=>Text(
                                  postController.boardValue.value.displayName,
                                  style: CommunityScreenTheme.boardDrawer,
                                ),),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return const BoardRadioButtonList();
                              },
                            );
                          },
                        )),
                    Builder(
                        builder: (context) => TextButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            overlayColor: null,
                          ),
                          child: Container(
                            width: MainSize.width * 0.8,
                            padding: EdgeInsets.only(bottom: MainSize.height * 0.006),
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white),
                                )),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(()=>Text(
                                  postController.filterValue.value.displayName,
                                  style: CommunityScreenTheme.boardDrawer,
                                ),),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return const FilterRadioButtonList();
                              },
                            );
                          },
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                      child: TextField(
                          focusNode: postController.focusNode.value,//titleFocus,
                          controller: postController.titleController.value,//_titleController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontFamily: "bmPro",
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "제목",
                            hintStyle: TextStyle(
                                fontFamily: "bmPro",
                                fontSize: 25,
                                color: Colors.grey),
                          )),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: contentCheckKeyBoard(),
                      top: contentPadding,
                      right: contentPadding,
                      left: contentPadding),
                  child: Obx(()=>HtmlEditor(
                    controller: postController.controller.value,
                    callbacks: Callbacks(
                        onFocus: (){
                          postController.unFocus();
                          //print(postController.filterValue.value.displayName);
                          //titleFocus.unfocus();
                        }
                    ),
                    otherOptions: OtherOptions(
                      height: MainSize.height,
                    ),
                  ),),
                ),
              ),
            ],
          ),
        ),
          Obx(()=>loadingController.loading.value ? const Loader() : const SizedBox()),
    ]  )

    );
  }
}
