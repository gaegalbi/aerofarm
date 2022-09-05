import 'package:capstone/model/BoardType.dart';
import 'package:capstone/service/getMyComment.dart';
import 'package:capstone/service/getMyPost.dart';
import 'package:capstone/widget/BoardAnnouncementWidget.dart';
import 'package:capstone/widget/BoardWidget.dart';
import 'package:capstone/widget/CommentWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../CommunityPageCustomLib/CommunityNotice.dart';
import '../main.dart';
import '../model/Board.dart';
import '../model/Comment.dart';
import '../model/Device.dart';
import '../model/Filter.dart';
import '../model/PostType.dart';
import '../model/Screen.dart';
import '../model/User.dart';
import '../themeData.dart';
import '../widget/DeviceWidget.dart';

class FloatingController extends GetxController{
  final floating = false.obs;

  void toggle(){
    floating.value = !floating.value;
  }

  void setUp(){
    floating.value = false;
  }
}

class UserController extends GetxController{
  final user = User().obs;


  void setUser(User input){
    user.value = input;
  }
}

class DeviceListController extends GetxController{
  final deviceList = <Widget>[].obs;

  void addDevice(Device device){
    deviceList.add(
      DeviceWidget(device: device)
    );
  }

  void setUp(){
    deviceList.clear();
  }
}
class DeviceController extends GetxController{
  final ledOnOff = false.obs;
  final temperature = 20.obs;
  final humidity = 50.obs;
  final fertilizer = 1.obs;
  /*DeviceController(Device device){
    ledOnOff.value = device.ledOn;
  }*/

  void setUp(Device device){
    ledOnOff.value = device.ledOn;
    temperature.value = device.temperature;
    humidity.value = device.humidity;
    fertilizer.value = device.fertilizer;
  }

  void setLed(bool input){
    ledOnOff.value = input;
  }

  void setTem(int input){
    temperature.value = input;
  }

  void setHum(int input){
    humidity.value = input;
  }

  void setFer(int input){
    fertilizer.value = input;
  }
}

class SearchController extends GetxController{
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

class SetCategoryController extends GetxController {
  final setCategory = "".obs;
  final List<bool> category = [true, false, false, false, false, false,].obs;

  void categoryClick(int index,String filter) {
    for (int i = 0; i < category.length; i++) {
      if (i != index) {
        category[i]= false;
      } else {
        category[i] = true;
      }
    }
    setCategory.value = filter;
  }
}

class LoadingController extends GetxController{
  final init = 0.0.obs;
  final distance = 0.0.obs;
  final loading = true.obs;
  late BuildContext context;

/*  void setStatus(){
    loading.toggle();
  }*/
  void setTrue(){
    loading.value = true;
  }
  void setFalse(){
    loading.value = false;
  }
  void setInit(double input){
    init.value = input;
  }
  void setDistance(double input){
    distance.value = input;
  }
}

class BoardListController extends GetxController{
  final boardList = <Widget>[].obs;
  final boardIdList = <int>[].obs;
  final boardParentList = <int>[].obs;

  //게시글
  void addBoard(Board board){
    boardList.add(
        BoardWidget(board: board,)
    );
  }

  //답글
  void boardInsert(int index, Board board){
    boardList.insert(index, BoardWidget(board: board,));
  }

  //답글
  void boardIdInsert(int index, int id){
    boardIdList.insert(index, id);
  }

  //중복방지
  void boardIdAdd(int id){
    boardIdList.add(id);
  }

  //중복방지
  void boardParentAdd(int index){
    boardParentList.add(index);
  }

  void boardIdClear(){
    boardIdList.clear();
    boardParentList.clear();
  }

  void boardClear(BoardType boardType){
    boardIdList.clear();
    boardList.clear();
    boardList.add(BoardAnnouncementWidget(boardType: boardType,));
  }
  void none(){
    boardList.add(Container(
        margin: EdgeInsets.only(
            top: Get.height * 0.345),
        alignment: Alignment.center,
        child: const Text(
          "게시글이 없습니다.",
          style: CommunityScreenTheme.announce,
        )));
  }
  void activityNone(){
    boardList.add(Container(
        margin: EdgeInsets.only(
            top: Get.height * 0.25),
        alignment: Alignment.center,
        child: const Text(
          "좋아요한 게시글이 없습니다.",
          style: CommunityScreenTheme.announce,
        )));
  }
}

class PageIndexController extends GetxController{
  final pageIndex = 1.obs;

  void increment(){
    pageIndex.value++;
  }
  void decrement(){
    pageIndex.value--;
  }
  void setUp(){
    pageIndex.value = 1;
  }
}


class CommentListController extends GetxController{
  final commentList= <Widget>[].obs;
  final commentGroupIdList = <int>[].obs;
  final commentIdList = <int>[].obs;
  final commentParentIdList = <int>[].obs;
  final commentPreventDuplicateIdList = <int>[].obs;
  final commentAnswerCount = 0.obs;
  final sort = false.obs;

  void setUpSort(){
    sort.value = false;
  }

  void toggleSort(){
    sort.value = !sort.value;
  }

  void commentAdd(Comment comment){
    commentList.add(
      CommentWidget(comment: comment,)
    );
  }

  void commentInsert(int index,Comment comment){
    commentList.insert(index, CommentWidget(comment: comment,));
  }

  void commentClear(){
    commentList.clear();
    commentParentIdList.clear();
    commentIdList.clear();
    commentGroupIdList.clear();
    commentPreventDuplicateIdList.clear();
    commentAnswerCount.value = 0;
  }
}

class AnnounceController extends GetxController{
 final board = Board().obs;

 void setBoard(Board input){
   board.value = input;
 }
}

class ModifySelectController extends GetxController{
  final modify= false.obs;
  final id = "".obs;
  final select = "".obs;

  //communityMenuWidget에서 ReplyDetailScreen에 board가 필요함
  final board = Board().obs;
  final comment = Comment().obs;

  void setId(String input){
    id.value = input;
  }
  void changeModify(){
    modify.value = !modify.value;
  }
  void setUpFalse(){
    modify.value = false;
  }
  void setUpTrue(){
    modify.value = true;
  }
  void clearId(){
    id.value="";
  }
  void setSelect(String input){
    select.value = input;
  }
  void setBoard(Board input){
    board.value = input;
  }
  void setComment(Comment input){
    comment.value = input;
  }
}

class RouteController extends GetxController{
  final current = Screen.undefined.obs;
  final before = Screen.undefined.obs;
  final beforeBoardType = BoardType.undefined.obs;
  final board = Board().obs;
  final commentCount = 0.obs; //readPostScreen 자체를 stateful로 만들기보다 routeController 에 commentCount 생성해서 넘겨주기로 함

  /*void setBefore(Screen input){
    before.value = input;
  }*/
  void setCurrent(Screen input){
    before.value = current.value;
    current.value = input;
  }

  void setCommentCount(int input){
    commentCount.value = input;
  }

  void setBoardType(BoardType input){
    beforeBoardType.value = input;
  }

  void setBoard(Board input){
    board.value = input;
  }
}

class PostController extends GetxController{
  final boardValue = BoardValue.undefined.obs; //게시판
  final filterValue = FilterValue.undefined.obs; //필터
  final controller = HtmlEditorController().obs;
  final focusNode = FocusNode().obs;
  final titleController = TextEditingController().obs;

  void unFocus(){
    focusNode.value.unfocus();
  }

  void setUp(){
    boardValue.value= BoardValue.undefined;
    filterValue.value = FilterValue.undefined;
  }
  void setUpSearch(){
    boardValue.value= BoardValue.all;
  }

  void setBoardValue(BoardValue input){
    boardValue.value = input;
  }

  void setFilterValue(FilterValue input){
    filterValue.value = input;
  }

  void setBoardValueBoardType(BoardType input){
    boardValue.value = BoardValue.getByCode(input.code);
  }

  void setFilterValueFilterType(FilterType input){
    filterValue.value = FilterValue.getByCode(input.code);
  }
}

class KeyController extends GetxController{
  late GlobalKey<ScaffoldState> scaffoldKey;

  void setKey(GlobalKey<ScaffoldState> key){
    scaffoldKey = key;
  }
}

class CustomTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;
  final index = 0.obs;
  final keyController = Get.put(KeyController());
  //final prevention = false.obs;

  @override
  void onInit() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      if(controller.index==0 && index.value != controller.index){
        checkTimerController.time.value ?
        checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
            getMyPostStart();
        //activityPostStartFetch();
      }
      if(controller.index==1 && index.value != controller.index){
        checkTimerController.time.value ?
        checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
            getMyCommentStart();
        //activityCommentStartFetch();
      }
      if(controller.index==2 && index.value != controller.index){
        checkTimerController.time.value ?
        checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
            getMyLikePostStart();
        //activityLikedStartFetch();
      }
      index.value = controller.index;
    });
    super.onInit();
  }

  void setTab(){
    switch(index.value){
      case 0:
        getMyPostStart();
        break;
      case 1:
        getMyCommentStart();
        break;
      case 2:
        getMyLikePostStart();
        break;
    }
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}
