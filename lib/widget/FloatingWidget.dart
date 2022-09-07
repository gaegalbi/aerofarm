import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityCreatePostScreen.dart';
import 'package:capstone/screen/CommunitySearchResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../model/Screen.dart';
import '../screen/CommunityActivityScreen.dart';
import '../screen/ProfileEditScreen.dart';
import '../service/normalFetch.dart';
import '../service/getMyPost.dart';
import '../service/searchFetch.dart';
import '../themeData.dart';

class FloatingWidget extends StatelessWidget {
  final Screen type;
  const FloatingWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());

    switch(type){
      case Screen.profileMain:
        return Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: MainColor.three,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                checkTimerController.time.value ?
                checkTimerController.stop(context) :Get.to(()=>const ProfileEditScreen());
              },
              icon: const Text("수정", style: CommunityScreenTheme.floatingButton,),)
        );
      case Screen.profileCommunity:
        final routeController = Get.put(RouteController());
        return SpeedDial(
            spacing: 8,
            spaceBetweenChildren: 10,
            icon: Icons.menu,
            backgroundColor: MainColor.three,
            childrenButtonSize: const Size(150,50),
            foregroundColor: Colors.white,
            children: [
              SpeedDialChild(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: MainColor.three,
                  ),
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                      "내 정보 수정", style: CommunityScreenTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  /* checkTimerController.time.value ?
                  checkTimerController.stop(context) :getRoute("CommunityPageEdit");*/
                },
              ),
              SpeedDialChild(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: MainColor.three,
                  ),
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                      "활동 보기", style: CommunityScreenTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: ()  {
                  routeController.setCurrent(Screen.activity);
                  getMyPostStart();
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CommunityActivityScreen()));
                  //Get.to(()=>const CommunityActivityScreen());
                  /* checkTimerController.time.value ?
                  checkTimerController.stop(context) :getRoute("CommunityPageEdit");*/
                },
              ),
            ]
        );
      case Screen.community:
        final searchController = Get.put(SearchController());
        final routeController = Get.put(RouteController());
        final textEditingController = TextEditingController();
        final boardListController = Get.put(BoardListController());
        return SpeedDial(
            spaceBetweenChildren: 5,
            icon: Icons.menu,
            backgroundColor: MainColor.three,
            foregroundColor: Colors.white,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.create_outlined),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  postController.setUp();
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                    Get.to(() => const CommunityCreatePostScreen(current: Screen.community,));
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.search_outlined),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        searchController.setSearch(0);
                        return GestureDetector(
                          onTap: (){
                            textEditingController.text = "";
                          },
                          child: AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
                              contentPadding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              backgroundColor: MainColor.six,
                              content: SizedBox(
                                height: MediaQuery.of(context).size.height*0.2,
                                width: MediaQuery.of(context).size.width*0.5,
                                child: Column(
                                  children: [
                                    Obx(()=>ToggleButtons(
                                      borderRadius: BorderRadius.circular(10),
                                      borderColor: Colors.transparent,
                                      selectedBorderColor: Colors.transparent,
                                      highlightColor: MainColor.six,
                                      children: <Widget>[
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.25,
                                            child: Text("제목",style:searchController.searchTitle.value ? CommunityScreenTheme.searchTextTrue : CommunityScreenTheme.searchTextFalse,textAlign: TextAlign.center,)),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.25,
                                            child: Text("작성자",style:searchController.searchWriter.value ? CommunityScreenTheme.searchTextTrue : CommunityScreenTheme.searchTextFalse,textAlign: TextAlign.center,)),
                                      ],
                                      onPressed: (int index) {
                                        searchController.setSearch(index);
                                      },
                                      isSelected: [searchController.searchTitle.value
                                        ,searchController.searchWriter.value ],
                                    ),),
                                    TextField(
                                      controller:textEditingController,
                                      textAlign:TextAlign.center,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "검색어를 입력하세요",
                                          hintStyle: LoginRegisterScreenTheme.hint),
                                    ),
                                    Container(
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
                                          Get.back();
                                          routeController.setCurrent(Screen.search);
                                          Get.to(()=>CommunitySearchResultScreen(search: searchController.getSearch(), keyword: textEditingController.text,));
                                        }
                                      }, child: const Text("검색",style:CommunityScreenTheme.searchButton,textAlign: TextAlign.center,)),
                                    )
                                  ],
                                ),
                              )
                          ),
                        );
                      });
                },
              ),
            ]
        );
    }
    return Container();
  }
}
