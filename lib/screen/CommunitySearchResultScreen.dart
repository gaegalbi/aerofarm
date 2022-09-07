import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/BoardType.dart';
import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../service/normalFetch.dart';
import '../service/searchFetch.dart';
import '../themeData.dart';
import '../widget/CustomAppBar.dart';
import '../widget/RadioButton.dart';
import 'CommunityScreen.dart';

class CommunitySearchResultScreen extends StatelessWidget {
  final String search;
  final String keyword;
  const CommunitySearchResultScreen({Key? key, required this.search, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingController = Get.put(LoadingController());
    final searchController = Get.put(SearchController());
    final boardListController = Get.put(BoardListController());
    final postController = Get.put(PostController());
    final routeController = Get.put(RouteController());
    final textEditingController = TextEditingController();

    String add = search == searchController.searchList[0] ? "제목" : "작성자";

    loadingController.setFalse();
    loadingController.context = context;
    routeController.isSearch.value = true;

    Future<bool> _onWillPop() async {
      routeController.setCurrent(Screen.community);
      Get.offAll(() => CommunityScreen(boardType: routeController.beforeBoardType.value));
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: MainColor.six,
          appBar: CustomAppBar(
            title: "도시농부",
            onPressed: () {
              loadingController.setTrue();
              routeController.setCurrent(Screen.community);
              Get.offAll(()=> const CommunityScreen(boardType: BoardType.all));
            },
            iconData: Icons.chevron_left,
            home: true,
          ),
          body: Obx(() => !loadingController.loading.value ? CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: false,
                collapsedHeight:MainSize.height * 0.2,
                leading: const SizedBox(),
                backgroundColor: MainColor.six,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Obx(()=>ToggleButtons(
                        constraints: BoxConstraints(
                            minWidth: MainSize.width * 0.25,
                            minHeight: MainSize.height * 0.05
                        ),
                        borderRadius: BorderRadius.circular(10),
                        borderColor: Colors.transparent,
                        selectedBorderColor: Colors.transparent,
                        highlightColor: MainColor.six,
                        children: <Widget>[
                          Text("제목",style:searchController.searchTitle.value ? CommunityScreenTheme.searchTextTrue : CommunityScreenTheme.searchTextFalse,textAlign: TextAlign.center,),
                          Text("작성자",style:searchController.searchWriter.value ? CommunityScreenTheme.searchTextTrue : CommunityScreenTheme.searchTextFalse,textAlign: TextAlign.center,),
                        ],
                        onPressed: (int index) {
                          searchController.setSearch(index);
                        },
                        isSelected: [searchController.searchTitle.value
                          ,searchController.searchWriter.value ],
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            width: MainSize.width * 0.4,
                            child: TextField(
                              controller:textEditingController,
                              textAlign:TextAlign.center,
                              decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "검색어를 입력하세요",
                                  hintStyle: LoginRegisterScreenTheme.hint),
                            ),
                          ),
                          Container(
                            height: MainSize.height*0.05,
                            decoration: BoxDecoration(
                                color: MainColor.three,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: TextButton(onPressed: () async {
                              if(textEditingController.text.isNotEmpty){
                                await searchStartFetch(searchController.getSearch(), textEditingController.text,routeController.beforeBoardType.value).then((value) => answerFetch(routeController.beforeBoardType.value));
                                postController.setUpSearch();
                                //searchController.searchKeyword.value = textEditingController.text;
                                textEditingController.text = "";
                              }
                            }, child: const Text("검색",style:CommunityScreenTheme.searchButton,textAlign: TextAlign.center,)),
                          ),
                        ],
                      ),
                      Builder(
                          builder: (context) => TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: null,
                            ),
                            child: Container(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.only(
                                  bottom:
                                  MediaQuery.of(context).size.height *
                                      0.006),
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
                                  return const SearchRadioButtonList();
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                    children: [
                      //안내 부분
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: MainSize.height * 0.01),
                          width: MainSize.width,
                          child: Text("$add 검색 결과",style: CommunityScreenTheme.searchInfo,)),
                      //검색 결과
                      Column(
                        children: boardListController.boardList,
                      )
                    ]
                ),
              )
              ]):SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: const Center(
                child: CircularProgressIndicator(
                  color: MainColor.three,
                )),
          ),
          )),
    );
  }
}
