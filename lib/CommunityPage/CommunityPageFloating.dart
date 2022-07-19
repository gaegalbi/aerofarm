import 'dart:convert';
import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/MainPage/MainPageDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';
import '../themeData.dart';
import 'CommunityPageCreatePost.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;

import 'CommunityPageForm.dart';

class SelectSearchController extends GetxController{
  final List<String> searchList = ["title","writer"];
  final searchTitle = true.obs;
  final searchWriter = false.obs;
  void setSearch(int index){
    if(index==0){
      searchTitle.value = true;
      searchWriter.value = false;
    }else{
      searchWriter.value = true;
      searchTitle.value = false;
    }
  }

  String getSearch(){
    if(searchTitle.value){
      return searchList[0];
    }else{
      return searchList[1];
    }
  }
}

class CommunityPageFloating extends StatelessWidget {
  final Map<String, dynamic> keywords;
  final String type;
  final String before;

  const CommunityPageFloating(
      {Key? key, required this.type, required this.keywords, required this.before,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nicknameController = Get.put(NicknameController());
    final selectSearchController = Get.put(SelectSearchController());
    final textEditingController =  TextEditingController();
    switch (type) {
      case "ReadPost":
        return keywords['deleteTnF'] ? Container():SpeedDial(
            spaceBetweenChildren: 5,
            icon: Icons.menu,
            backgroundColor: MainColor.three,
            foregroundColor: Colors.white,
            children: [
              keywords['writer'] == nicknameController.nickname.value ? SpeedDialChild(
                child: const Text(
                  "삭제", style: CommunityPageTheme.floatingButton,),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                onTap: () async {
                  var body = json.encode({"id": keywords['id']});
                  await http.post(
                    Uri.http(serverIP, '/deletePost'),
                    headers: {
                      "Content-Type": "application/json",
                      "Cookie": "JSESSIONID=$session",
                    },
                    encoding: Encoding.getByName('utf-8'),
                    body: body,
                  );
                  Get.offAll(() => CommunityPageForm(category: before));
                },
              ) : SpeedDialChild(),
              keywords['writer'] ==  nicknameController.nickname.value ? SpeedDialChild(
                child: const Text(
                  "수정", style: CommunityPageTheme.floatingButton,),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                  Get.to(() => CommunityPageCreatePost(keywords: keywords,
                    type: "UpdatePost",
                    before: before,));
                },
              ) : SpeedDialChild(),
              SpeedDialChild(
                child: const Text(
                  "답글", style: CommunityPageTheme.floatingButton,),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                  Get.to(() => CommunityPageCreatePost(
                    keywords: keywords, type: type, before: before,));
                },
              ),
            ]
        );
      case "Profile":
        return Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: MainColor.three,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                checkTimerController.time.value ?
                checkTimerController.stop(context) :getProfile("MainPageMyProfile");
              },
              icon: const Text("수정", style: CommunityPageTheme.floatingButton,),)
        );
      case "CommunityProfile":
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
                      "내 정보 수정", style: CommunityPageTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :getProfile("CommunityPageEdit");
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
                    "활동 보기", style: CommunityPageTheme.floatingButton),
                ),
                backgroundColor: MainColor.three,
                foregroundColor: Colors.white,
                onTap: () {
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :getProfile("CommunityPageEdit");
                },
              ),
            ]
        );
      default :
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
                  checkTimerController.time.value ?
                  checkTimerController.stop(context) :
                  Get.to(() => CommunityPageCreatePost(
                    keywords: keywords, type: type, before: before,));
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
                        selectSearchController.setSearch(0);
                        return AlertDialog(
                          contentPadding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                          backgroundColor: MainColor.six,
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Column(
                              children: [
                                Obx(()=>ToggleButtons(
                                  borderColor: Colors.transparent,
                                  selectedBorderColor: Colors.transparent,
                                  highlightColor: MainColor.six,
                                  children: <Widget>[
                                   SizedBox(
                                       width: MediaQuery.of(context).size.width*0.25,
                                       child: Text("제목",style:selectSearchController.searchTitle.value ? CommunityPageTheme.searchTextTrue : CommunityPageTheme.searchTextFalse,textAlign: TextAlign.center,)),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width*0.25,
                                        child: Text("작성자",style:selectSearchController.searchWriter.value ? CommunityPageTheme.searchTextTrue : CommunityPageTheme.searchTextFalse,textAlign: TextAlign.center,)),
                                  ],
                                  onPressed: (int index) {
                                      selectSearchController.setSearch(index);
                                  },
                                  isSelected: [selectSearchController.searchTitle.value
                                  ,selectSearchController.searchWriter.value ],
                                ),),
                                  TextField(
                                   controller:textEditingController,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "검색어를 입력하세요",
                                      hintStyle: LoginRegisterPageTheme.hint),
                                ),
                                Container(
                                  color:MainColor.three,
                                  child: TextButton(onPressed: (){
                                    if(textEditingController.text.isNotEmpty){
                                      searchFetch(keywords['category'], selectSearchController.getSearch(), textEditingController.text).then((value) => answerFetch(keywords['category']));
                                      Get.back();
                                    }
                                  }, child: const Text("검색",style:CommunityPageTheme.searchButton,textAlign: TextAlign.center,)),
                                )
                              ],
                            ),
                          )
                        );
                      });
                },
              ),
            ]
        );
    }
  }
}