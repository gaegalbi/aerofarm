import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/LoginPage/LoginPageLogin.dart';
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
  final categoryIndexController  = Get.put(CategoryIndexController());
  final setCategoryController  = Get.put(SetCategoryController());
  late ScrollController _scrollController;
  late ScrollController _categoryController;
  bool floating = false;
  bool refresh = false;

  void handleScrolling(bool expand) {
    if(expand){
      //전체게시판은 전체 게시물을 전부 불러올 거라서 전체게시판이나 인기게시판일때는 동작x
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent &&
          !(widget.category == 'all' || widget.category == 'hot')) {
        pageIndexController.increment();
        keywords.clear();
        fetch(widget.category,false);
      }
      if (_scrollController.offset ==
          _scrollController.position.minScrollExtent) {
        //keywords.clear();
        setState(() {
          boardListController.boardClear();
          pageIndexController.setUp();
          categoryIndexController.setUp();
          loadingController.setTrue();
          fetch(widget.category,false);
          Future.delayed(const Duration(microseconds: 100), () {
            loadingController.setFalse();
          });
        });
      }
    }else{
      print("work");
      fetch(widget.category,false);
      loadingController.setTrue();
      Future.delayed(const Duration(milliseconds: 300), () {
        loadingController.setFalse();
        refresh = false;
      });

    }

  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _scrollController.addListener(() {
      handleScrolling(true);
    });
    commentListController.commentClear();
    boardListController.boardClear();
    fetch(widget.category,false);
    loadingController.setTrue();
    Future.delayed(const Duration(milliseconds: 300), () {
      loadingController.setFalse();
    });
    super.initState();
  }

  @override
  void dispose() {
    boardListController.dispose();
    loadingController.dispose();
    pageIndexController.dispose();
    categoryIndexController.dispose();
    _scrollController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        print(checkTimerController.time.value);
        setState(() {
          floating = !floating;
        });
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: floating
            ? CommunityPageFloating(
                keywords: {"communityCategory":widget.category},
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
                                      setCategoryController.categoryClick(0);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[0]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "자유",
                                  onPressed: () {
                                    setState(() {
                                      setCategoryController.categoryClick(1);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[1]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "사진",
                                  onPressed: () {
                                    setState(() {
                                      setCategoryController.categoryClick(2);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[2]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "정보",
                                  onPressed: () {
                                    setState(() {
                                      setCategoryController.categoryClick(3);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[3]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "질문",
                                  onPressed: () {
                                    setState(() {
                                      setCategoryController.categoryClick(4);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[4]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                              TitleButton(
                                  title: "거래",
                                  onPressed: () {
                                    setState(() {
                                      setCategoryController.categoryClick(5);
                                      fetch(widget.category,false);
                                    });
                                  },
                                  style: setCategoryController.category[5]
                                      ? CommunityPageTheme.titleButtonTrue
                                      : CommunityPageTheme.titleButtonFalse),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              GestureDetector(
                onVerticalDragUpdate: (dragUpdateDetails) {
                  if (dragUpdateDetails.delta.dy > 40 && !refresh) {
                    setState((){
                      refresh = true;
                    });
                   Future.delayed(const Duration(milliseconds: 100),()=>handleScrolling(false));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.014,
                  ),
                  //height: MediaQuery.of(context).size.height * 0.69,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Obx(()=>Column(children: [
                    !(loadingController.loading.value)
                        ? Expanded(
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount:   boardListController.boardList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <  boardListController.boardList.length) {
                                    return  boardListController.boardList[index];
                                  } else{
                                    return Container();
                                  }
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
