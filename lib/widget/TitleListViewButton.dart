import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/model/BoardType.dart';
import 'package:capstone/model/FilterType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../provider/Controller.dart';
import '../service/hotFetch.dart';
import '../service/normalFetch.dart';
import '../themeData.dart';

class TitleListViewButton extends StatelessWidget {
  final BoardType boardType;
  const TitleListViewButton({Key? key, required this.boardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setCategoryController = Get.put(SetCategoryController());
    final loadingController = Get.put(LoadingController());

    return Obx(()=>ListView(
      //controller: _categoryController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        TitleButton(
            title: BoardType.all.displayName.substring(0,BoardType.all.displayName.length-3),
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(0, BoardType.all);
              }else {
                setCategoryController.filterClick(0, FilterType.all);
              }

              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[0]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.free.displayName.substring(0,BoardType.all.displayName.length-3) : "일반",
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(1, BoardType.free);
              }else {
                setCategoryController.filterClick(1, FilterType.normal);
              }
              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[1]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.picture.displayName.substring(0,BoardType.all.displayName.length-3) : "취미",
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(2, BoardType.picture);
              }else {
                setCategoryController.filterClick(2, FilterType.hobby);
              }
              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[2]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.info.displayName.substring(0,BoardType.all.displayName.length-3) : "게임",
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(3, BoardType.info);
              }else {
                setCategoryController.filterClick(3,FilterType.game);
              }
              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }

              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[3]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.question.displayName.substring(0,BoardType.all.displayName.length-3) : "일상",
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(4, BoardType.question);
              }else {
                setCategoryController.filterClick(4,FilterType.daily);
              }
              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[4]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.trade.displayName.substring(0,BoardType.all.displayName.length-3) : "여행",
            onPressed: () {
              if(boardType == BoardType.hot){
                setCategoryController.categoryClick(5, BoardType.trade);
              }else {
                setCategoryController.filterClick(5,FilterType.travel);
              }
              loadingController.setTrue();
              if(boardType == BoardType.hot) {
                startHotProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }else{
                startProcess(boardType,setCategoryController.check()).then((value) => loadingController.setFalse());
              }
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[5]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
      ],
    ));
  }
}


class TitleButton extends StatelessWidget {
  const TitleButton({Key? key, required this.title, required this.onPressed, required this.style}) : super(key: key);
  final String title;
  final Function onPressed;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.12,
      child: TextButton(
        onPressed: (){
          onPressed();
        },
        child: Text(title,style: style),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero
        ),
      ),
    );
  }
}