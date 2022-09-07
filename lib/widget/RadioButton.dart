import 'package:capstone/model/BoardType.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/FilterType.dart';
import '../model/PostType.dart';
import '../themeData.dart';

class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T boardValue;
  //final void Function(T?)? onChanged;
  final Color? activeColor;
  final TextStyle? textStyle;
  final double contentPadding;
  final bool board;

  const RadioButton(
      {Key? key,
        required this.description,
        required this.value,
        required this.boardValue,
        //this.onChanged,
        this.activeColor,
        this.textStyle,
        required this.contentPadding, required this.board})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    return InkWell(
      onTap: () {
       // if (onChanged != null) {
          if(board){
            postController.setBoardValue(value as BoardType);
          }else{
            postController.setFilterValue(value as FilterType);
          }
         // onChanged!(value);
          Navigator.pop(context);
         // Get.back();
       // }
      },
      child: Container(
        margin: EdgeInsets.only(
            top: contentPadding / 3, bottom: contentPadding / 3),
        padding: EdgeInsets.only(
          left: contentPadding,
          right: contentPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              description,
              style: textStyle,
              textAlign: TextAlign.left,
            ),
            Transform.scale(
              scale: 1.5,
              child: Radio<T>(
                groupValue: boardValue,
                onChanged: (value)=>(){},
                value: value,
                activeColor: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardRadioButtonList extends StatelessWidget {
  const BoardRadioButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    const double contentPadding = 30;

    return Container(
      color: MainColor.six,
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Obx(()=>Column(
          children: <Widget>[
            const Icon(
              Icons.remove,
              color: Colors.white,
              size: 60,
            ),
            Container(
              alignment:
              Alignment.centerLeft,
              margin: EdgeInsets.only(
                  bottom: 15, left: 30),
              child: const Text(
                "게시판 선택",
                style: TextStyle(
                    fontFamily: "bmPro",
                    fontSize: 30,
                    color: MainColor.three),
              ),
            ),
            RadioButton(
              contentPadding: contentPadding,
              description: BoardType.free.displayName,
              value: BoardType.free,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
              //onChanged: (value)=>(){},
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.question.displayName,
              value: BoardType.question,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.info.displayName,
              value: BoardType.info,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.picture.displayName,
              value: BoardType.picture,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.trade.displayName,
              value: BoardType.trade,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.announcement.displayName,
              value: BoardType.announcement,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===1",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===2",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===3",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===4",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===5",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
          ],
        ),),
      ),
    );
  }
}

class SearchRadioButtonList extends StatelessWidget {
  const SearchRadioButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    const double contentPadding = 30;

    return Container(
      color: MainColor.six,
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Obx(()=>Column(
          children: <Widget>[
            const Icon(
              Icons.remove,
              color: Colors.white,
              size: 60,
            ),
            Container(
              alignment:
              Alignment.centerLeft,
              margin: EdgeInsets.only(
                  bottom: 15, left: 30),
              child: const Text(
                "게시판 선택",
                style: TextStyle(
                    fontFamily: "bmPro",
                    fontSize: 30,
                    color: MainColor.three),
              ),
            ),
            RadioButton(
              contentPadding: contentPadding,
              description: BoardType.all.displayName,
              value: BoardType.all,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
              //onChanged: (value)=>(){},
            ),
            RadioButton(
              contentPadding: contentPadding,
              description: BoardType.free.displayName,
              value: BoardType.free,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
              //onChanged: (value)=>(){},
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.question.displayName,
              value: BoardType.question,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.info.displayName,
              value: BoardType.info,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.picture.displayName,
              value: BoardType.picture,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.trade.displayName,
              value: BoardType.trade,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: BoardType.announcement.displayName,
              value: BoardType.announcement,
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===1",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===2",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===3",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===4",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===5",
              boardValue: postController.boardValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable, board: true,
            ),
          ],
        ),),
      ),
    );
  }
}

class FilterRadioButtonList extends StatelessWidget {
  const FilterRadioButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    const double contentPadding = 30;

    return Container(
      color: MainColor.six,
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Obx(()=>Column(
          children: <Widget>[
            const Icon(
              Icons.remove,
              color: Colors.white,
              size: 60,
            ),
            Container(
              alignment:
              Alignment.centerLeft,
              margin: const EdgeInsets.only(
                  bottom: 15, left: 30),
              child: const Text(
                "게시판 선택",
                style: TextStyle(
                    fontFamily: "bmPro",
                    fontSize: 30,
                    color: MainColor.three),
              ),
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: FilterType.normal.displayName,
              value: FilterType.normal,
              boardValue: postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: FilterType.hobby.displayName,
              value: FilterType.hobby,
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: FilterType.game.displayName,
              value: FilterType.game,
              boardValue: postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: FilterType.daily.displayName,
              value: FilterType.daily,
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: FilterType.travel.displayName,
              value: FilterType.travel,
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxFont, board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===0",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme.checkBoxDisable,
               board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===1",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable,
               board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===2",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable,
              board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===3",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable,
              board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===4",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable,
              board: false,
            ),
            RadioButton(
              contentPadding:
              contentPadding,
              description: "===",
              value: "===5",
              boardValue:  postController.filterValue.value,
              activeColor: MainColor.three,
              textStyle: CommunityScreenTheme
                  .checkBoxDisable,
               board: false,
            ),
          ],
        ),),
      ),
    );
  }
}


