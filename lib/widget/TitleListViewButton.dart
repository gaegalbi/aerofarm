import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/model/BoardType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../provider/Controller.dart';
import '../themeData.dart';

class TitleListViewButton extends StatelessWidget {
  final BoardType boardType;
  const TitleListViewButton({Key? key, required this.boardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setCategoryController = Get.put(SetCategoryController());
    return Obx(()=>ListView(
      //controller: _categoryController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        TitleButton(
            title: BoardType.all.displayName.substring(0,BoardType.all.displayName.length-3),
            onPressed: () {
              setCategoryController.categoryClick(0, BoardType.all.code );
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[0]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.free.displayName.substring(0,BoardType.all.displayName.length-3) : "일반",
            onPressed: () {
              setCategoryController.categoryClick(1, boardType == BoardType.hot ? BoardType.free.code : "NORMAL");

              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[1]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.picture.displayName.substring(0,BoardType.all.displayName.length-3) : "취미",
            onPressed: () {
              setCategoryController.categoryClick(2, boardType == BoardType.hot ? BoardType.picture.code : "HOBBY");
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[2]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.info.displayName.substring(0,BoardType.all.displayName.length-3) : "게임",
            onPressed: () {
              setCategoryController.categoryClick(3, boardType == BoardType.hot ? BoardType.info.code : "GAME");
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[3]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.question.displayName.substring(0,BoardType.all.displayName.length-3) : "일상",
            onPressed: () {
              setCategoryController.categoryClick(4, boardType == BoardType.hot ? BoardType.question.code : "DAILY");
              //categoryFetch(widget.category);
            },
            style: setCategoryController.category[4]
                ? CommunityScreenTheme.titleButtonTrue
                : CommunityScreenTheme.titleButtonFalse),
        TitleButton(
            title: boardType == BoardType.hot ? BoardType.trade.displayName.substring(0,BoardType.all.displayName.length-3) : "여행",
            onPressed: () {
              setCategoryController.categoryClick(5, boardType == BoardType.hot ? BoardType.trade.code  : "TRAVEL");
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