import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../CommunityPageCustomLib/CommunityNeed.dart';
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
  late ScrollController _scrollController;
  late ScrollController _categoryController;
  final boardListController = Get.put(BoardListController());
  final loadingController = Get.put(LoadingController());
  final pageIndexController = Get.put(PageIndexController());
  final categoryIndexController = Get.put(CategoryIndexController());
 // bool loading = true;
  bool floating = false;

  void handleScrolling() {
    //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !(widget.category == 'all' || widget.category == 'hot')) {
      pageIndexController.increment();
      keywords.clear();
      fetch();
    }
    if (_scrollController.offset ==
        _scrollController.position.minScrollExtent) {
      //keywords.clear();
      setState(() {
        boardListController.boardClear();
        pageIndexController.setUp();
        categoryIndexController.setUp();
        loadingController.setTrue();
        fetch();
        Future.delayed(const Duration(microseconds: 100), () {
          loadingController.setFalse();
        });
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling();
    });
    commentList.clear();
    boardListController.boardClear();
    fetch();
    loadingController.setTrue();
    Future.delayed(const Duration(microseconds: 100), () {
      loadingController.setFalse();
    });
    super.initState();
  }

  @override
  void dispose() {
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
        floatingActionButton: floating
            ? CommunityPageFloating(
                id: widget.category,
                type: 'Form',
                title: "",
              )
            : null,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toobarHeight,
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
            style: MainTheme.title,
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
                  constraints: const BoxConstraints(),
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
            MediaQuery.of(context).size.width * 0.04,
            0,
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.width * 0.04,
          ),
          color: MainColor.six,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    matchCategory[widget.category]!,
                    style: CommunityPageTheme.title,
                  ),
                  widget.category == "hot"
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.039,
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.021,
                          ),
                          child: ListView(
                            controller: _categoryController,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              TitleButton(
                                  title: "전체",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(0);
                                      fetch();
                                    });
                                  },
                                  style: category[0]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "자유",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(1);
                                      fetch();
                                    });
                                  },
                                  style: category[1]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "사진",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(2);
                                      fetch();
                                    });
                                  },
                                  style: category[2]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "정보",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(3);
                                      fetch();
                                    });
                                  },
                                  style: category[3]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "질문",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(4);
                                      fetch();
                                    });
                                  },
                                  style: category[4]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "거래",
                                  onPressed: () {
                                    setState(() {
                                      categoryClick(5);
                                      fetch();
                                    });
                                  },
                                  style: category[5]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.014,
                ),
                height: MediaQuery.of(context).size.height * 0.69,
                child: Column(children: [
                  loadingController.loading.value
                      ? Expanded(
                          child: Obx(()=>ListView.builder(
                              controller: _scrollController,
                              itemCount:   boardListController.boardList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index <  boardListController.boardList.length) {
                                  return  boardListController.boardList[index];
                                } else {
                                  return Container();
                                }
                              })))
                      : const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: MainColor.three,
                        ))),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
