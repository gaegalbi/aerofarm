import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPageCreatePost extends StatefulWidget {
  const CommunityPageCreatePost({Key? key}) : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost> {
  final List<String> value = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];
  String groupValue = "게시판 선택";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MainSize.toobarHeight / 2,
        elevation: 0,
        backgroundColor: MainColor.six,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.offAll(() => const CommunityPageAll());
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "등록",
                  style: CommunityPageTheme.postFont,
                )),
          )
        ],
      ),
      body: Container(
        color: MainColor.six,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Builder(
              builder: (context) => TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: null,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.006),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            groupValue,
                            style: CommunityPageTheme.boardDrawer,
                          ),
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
                          return Container(
                            color: MainColor.six,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: 20, bottom: 15, left: 30),
                                    child: const Text(
                                      "게시판 선택",
                                      style: TextStyle(
                                          fontFamily: "bmPro", fontSize: 30, color: MainColor.three),
                                    ),
                                  ),
                                  RadioButton(
                                    description: value[0],
                                    value: value[0],
                                    groupValue: groupValue,
                                    onChanged: (value) => setState(() {
                                      groupValue = value as String;
                                      Get.back();
                                    }),
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxFont,
                                  ),
                                  RadioButton(
                                    description: value[1],
                                    value: value[1],
                                    groupValue: groupValue,
                                    onChanged: (value) => setState(() {
                                      groupValue = value as String;
                                      Get.back();
                                    }),
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxFont,
                                  ),
                                  RadioButton(
                                    description: value[2],
                                    value: value[2],
                                    groupValue: groupValue,
                                    onChanged: (value) => setState(() {
                                      groupValue = value as String;
                                      Get.back();
                                    }),
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxFont,
                                  ),
                                  RadioButton(
                                    description: value[3],
                                    value: value[3],
                                    groupValue: groupValue,
                                    onChanged: (value) => setState(() {
                                      groupValue = value as String;
                                      Get.back();
                                    }),
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxFont,
                                  ),
                                  RadioButton(
                                    description: value[4],
                                    value: value[4],
                                    groupValue: groupValue,
                                    onChanged: (value) => setState(() {
                                      groupValue = value as String;
                                      Get.back();
                                    }),
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxFont,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===0",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===1",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===2",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===3",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===4",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                  RadioButton(
                                    description: "===",
                                    value: "===5",
                                    groupValue: groupValue,
                                    activeColor: MainColor.three,
                                    textStyle: CommunityPageTheme.checkBoxDisable,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ))
        ]),
      ),
    );
  }
}

class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final Color? activeColor;
  final TextStyle? textStyle;

  const RadioButton(
      {Key? key,
        required this.description,
        required this.value,
        required this.groupValue,
        this.onChanged,
        this.activeColor,
        this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
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
                groupValue: groupValue,
                onChanged: onChanged,
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