import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../CommunityPageCustomLib/CommunityTitleButton.dart';
import 'CommunityPageFloating.dart';

class CommunityPageForm extends StatefulWidget {
  final String category;

  const CommunityPageForm({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CommunityPageForm> createState() => _CommunityPageFormState();
}

class _CommunityPageFormState extends State<CommunityPageForm> {
  final boardListController = Get.put(BoardListController());
  final commentListController = Get.put(CommentListController());
  final loadingController = Get.put(LoadingController());
  final pageIndexController = Get.put(PageIndexController());
  final setCategoryController  = Get.put(SetCategoryController());
  final replyDetailController  = Get.put(ReplyDetailListController());

  late ScrollController _scrollController;
  late ScrollController _categoryController;
  bool floating = false;
  double initial = 0;
  double distance = 0;

  void handleScrolling() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
       // keywords.clear();
        loadFetch(widget.category).then((value) => answerFetch(widget.category));
      }
      if (_scrollController.offset == _scrollController.position.minScrollExtent) {
          loadingController.setTrue();
          startFetch(widget.category).then((value)=>answerFetch(widget.category)).then((value)=>loadingController.setFalse());
      }
  }

  @override
  void initState() {
    replyDetailController.replyDetailSetUp();
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    loadingController.setTrue();
    commentListController.commentClear();
    boardListController.boardClear();
    startFetch(widget.category).then((value) => answerFetch(widget.category)).then((value)=>loadingController.setFalse());

    super.initState();
  }

  @override
  void dispose() {
    boardListController.dispose();
    loadingController.dispose();
    pageIndexController.dispose();
    _scrollController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          floating = !floating;
        });
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: floating
            ? CommunityPageFloating(
                keywords: {"category":widget.category},
                type: 'Form',
                before: widget.category,
              )
            : null,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toolbarHeight,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: FittedBox(
                child: Builder(
              builder: (context) => IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )),
          ),
          title: const Text(
            "도시농부",
            style: MainPageTheme.title,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  /*constraints: const BoxConstraints(),*/
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {
                    Get.off(() => const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height,
          child: const Drawer(
            backgroundColor: Colors.black,
            child: CommunityPageDrawer(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.03,
            0,
            MediaQuery.of(context).size.width * 0.03,
            MediaQuery.of(context).size.width * 0.04,
          ),
          color: MainColor.six,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    matchCategory[widget.category.toString()]!,
                    style: CommunityPageTheme.title,
                  ),
                  Container(
                          height: MediaQuery.of(context).size.height * 0.039,
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.021,
                          ),
                          child: Obx(()=>ListView(
                            controller: _categoryController,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              TitleButton(
                                  title: "전체",
                                  onPressed: () {
                                      setCategoryController.categoryClick(0,"ALL");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[0]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: widget.category == "HOT" ? "자유" : "일반",
                                  onPressed: () {
                                      setCategoryController.categoryClick(1,widget.category == "HOT" ? "FREE" : "NORMAL");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[1]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: widget.category == "HOT" ? "사진" : "취미",
                                  onPressed: () {
                                      setCategoryController.categoryClick(2,widget.category == "HOT" ? "PICTURE" : "HOBBY");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[2]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: widget.category == "HOT" ? "정보" : "게임",
                                  onPressed: () {
                                      setCategoryController.categoryClick(3,widget.category == "HOT" ? "INFORMATION" : "GAME");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[3]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: widget.category == "HOT" ? "질문" : "일상",
                                  onPressed: () {
                                      setCategoryController.categoryClick(4,widget.category == "HOT" ? "QUESTION" : "DAILY");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[4]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title:widget.category == "HOT" ?  "거래" : "여행",
                                  onPressed: () {
                                      setCategoryController.categoryClick(5,widget.category == "HOT" ? "TRADE" : "TRAVEL");
                                      categoryFetch(widget.category);
                                  },
                                  style: setCategoryController.category[5]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                            ],
                          )),
                        )
                ],
              ),
              GestureDetector(
                  onVerticalDragStart: (dragStartDetails){
                    initial = dragStartDetails.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (dragUpdateDetails) {
                    distance = dragUpdateDetails.globalPosition.dy - initial;
                  },
                onVerticalDragEnd: (dragEndDetails){
                    //print(distance);
                    if(boardListController.boardList.length<10 && distance>=200){
                      loadingController.setTrue();
                      startFetch(widget.category).then((value)=>answerFetch(widget.category)).then((value)=>loadingController.setFalse());
                    }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.014,
                  ),
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Obx(()=>Column(children: [
                    !(loadingController.loading.value)
                        ? Expanded(
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount:   boardListController.boardList.length,
                                //itemCount:   boardListController.boardList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                    return  boardListController.boardList[index];
                                }))
                        : const Expanded(
                            child: Center(
                                child: CircularProgressIndicator(
                            color: MainColor.three,
                          ))),
                  ]),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
