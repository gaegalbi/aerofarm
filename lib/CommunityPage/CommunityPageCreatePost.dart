import 'dart:async';
import 'dart:convert';
import 'package:capstone/main.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../CommunityPageCustomLib/CustomRadioButton.dart';
import 'package:http/http.dart' as http;
import '../LoginPage/LoginPageLogin.dart';
import 'CommunityPageForm.dart';

class CommunityPageCreatePost extends StatefulWidget {
  final Map<String,dynamic> keywords;
  final String type;
  final String before;

  const CommunityPageCreatePost(
      {Key? key, required this.type, required this.keywords, required this.before})
      : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost>
    with TickerProviderStateMixin {
  final List<String> categoryValue = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];
  final List<String> classValue = ["일반","취미","게임","일상","여행"];

  final double floatingBarSize = 60;
  final double contentPadding = 30;
  double contentBottomPadding = 30;
  String groupValue = "게시판 선택";
  String classificationValue = "분류 선택";

  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late TextEditingController _titleController;
  late HtmlEditorController _controller;

  final readPostController = Get.put(ReadPostController());

  var data = <String, dynamic>{};
  final Map<String, String> korToEngCategory = {
    "자유 게시판": "free",
    "정보 게시판": "information",
    "질문 게시판": "question",
    "사진 게시판": "picture",
    "거래 게시판": "trade"
  };
  final Map<String, String> engToKorCategory = {
    "free":"자유 게시판",
    "information": "정보 게시판",
    "question": "질문 게시판",
    "picture":"사진 게시판",
    "trade" : "거래 게시판"
  };
  final Map<String, String> korToEngClass = {
    "일반": "normal",
    "취미": "hobby",
    "게임": "game",
    "일상": "daily",
    "여행": "travel"
  };

  late FocusNode titleFocus;

  @override
  void initState() {
    titleFocus = FocusNode();
    _controller = HtmlEditorController();
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    _titleController = TextEditingController();
    if(widget.type =="UpdatePost") {
      classificationValue = widget.keywords['filter'].toString().toLowerCase();
      groupValue = engToKorCategory[widget.keywords['category'].toString().toLowerCase()]!;
      _titleController.text = widget.keywords['title'];
      //_controller.setText(readPostController.content.value);
    }
    if(widget.type =="ReadPost"){
      _titleController.text = "Re : " + widget.keywords['title'];
    }
    super.initState();
    Future.delayed(const Duration(milliseconds: 400),()=> {
        if(widget.type !="ReadPost"){
          _controller.setText(readPostController.content.value)
      }
    });
  }

  @override
  void dispose() {
    _controller.disable();
    _scrollController.dispose();
    _scrollController1.dispose();
    _titleController.dispose();
    super.dispose();
  }

  double contentCheckKeyBoard() {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      return MediaQuery.of(context).viewInsets.bottom;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MainSize.toolbarHeight / 2,
        elevation: 0,
        backgroundColor: MainColor.six,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            //화면 전환시 키보드 부드럽게 내려가게
            _controller.editorController?.clearFocus();
            _controller.disable();
            Future.delayed(const Duration(microseconds: 1), () {
              widget.type == "UpdatePost" || widget.type=="ReadPost" ? Get.back() : Get.offAll(() => CommunityPageForm(category:widget.before));
            });
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: MainColor.three,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
                onPressed: () async {
                  if (widget.type == "ReadPost") {
                    //답글 쓰기
                    if (_controller.getText().toString().length == 1) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 900),
                                () {
                              Navigator.pop(context);
                            });
                            return const AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(5),
                              content: Text(
                                "게시판 종류,제목,내용이\n있어야합니다.",
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                            );
                          });
                    } else {
                      //세션 만료 확인
                      if(checkTimerController.time.value){
                        checkTimerController.stop(context);
                      }else{
                        final txt = await _controller.getText();
                        data = {
                          "id":'',
                          "category": widget.keywords['category'].toString().toLowerCase(),
                          "filter":widget.keywords['filter'].toString().toLowerCase(),
                          "title":_titleController.text,
                          "contents": txt,
                          "postId": widget.keywords['id'],
                        };
                        var body = json.encode(data);
                        await http.post(
                          Uri.http(
                              ipv4, '/createAnswerPost'),
                          headers: {
                            "Content-Type": "application/json",
                            "Cookie": "JSESSIONID=$session",
                          },
                          encoding: Encoding.getByName('utf-8'),
                          body: body,
                        );
                        _controller.editorController?.clearFocus();
                        _controller.disable();
                        Future.delayed(const Duration(microseconds: 1), () {
                          Get.offAll(() => CommunityPageForm(category:widget.before));
                        });
                      }
                    }
                  }
                  else {
                    //그냥 글쓰기
                    if (korToEngCategory[groupValue] == null ||korToEngClass[classificationValue] == null ||
                        _titleController.text.isEmpty ||
                        _controller.getText().toString().length == 1) {
                      /*_controller.document.toPlainText().length==1){*/
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 900),
                                () {
                              Navigator.pop(context);
                            });
                            return const AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(5),
                              content: Text(
                                "게시판 종류,분류,제목,내용이\n있어야합니다.",
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                            );
                          });
                    } else {
                      //세션 만료됬는지 확인
                      if(checkTimerController.time.value){
                        checkTimerController.stop(context);
                      }else{
                        final txt = await _controller.getText();
                        if(widget.type == "UpdatePost"){
                          data = {
                            "id":widget.keywords['id'],
                            "category": korToEngCategory[groupValue],
                            "filter":korToEngClass[classificationValue],
                            "title": _titleController.text,
                            "contents": txt,
                            "postId":'',
                          };
                          var body = json.encode(data);
                          await http.post(
                            Uri.http(ipv4, '/updatePost'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie": "JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                        }else{
                          //createBasicPost
                          data = {
                            "id":'',
                            "category": korToEngCategory[groupValue],
                            "filter":korToEngClass[classificationValue],
                            "title": _titleController.text,
                            "contents": txt,
                            "postId":'',
                          };
                          var body = json.encode(data);

                          await http.post(
                            Uri.http(ipv4, '/createBasicPost'),
                            headers: {
                              "Content-Type": "application/json",
                              "Cookie": "JSESSIONID=$session",
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: body,
                          );
                        }
                        _controller.editorController?.clearFocus();
                        _controller.disable();
                        //Get.offAll(() => CommunityPageForm(category: widget.keywords['communityCategory']));
                        Future.delayed(const Duration(microseconds: 1), () {
                          Get.offAll(() => CommunityPageForm(category:widget.before));
                        });
                      }
                    }
                  }
                },
                child: const Text(
                  "등록",
                  style: CommunityPageTheme.postFont,
                )),
          )
        ],
      ),
      body: Container(
        color: MainColor.six,
        child: CustomScrollView(
          controller: _scrollController1,
          slivers: [
            (widget.type == "ReadPost" || widget.type == "UpdatePost")
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                          child: TextField(
                              focusNode: titleFocus,
                              controller: _titleController,
                              style: const TextStyle(
                                fontFamily: "bmPro",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                //hintText: "Re : " + widget.keywords['title'],
                                hintStyle: TextStyle(
                                    fontFamily: "bmPro",
                                    fontSize: 25,
                                    color: Colors.grey),
                              )),
                        ),
                      ],
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Column(
                      children: [
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: SingleChildScrollView(
                                            child: Column(
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
                                                  contentPadding:
                                                      contentPadding,
                                                  description: categoryValue[0],
                                                  value: categoryValue[0],
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    groupValue =
                                                        value as String;
                                                    Get.back();
                                                  }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxFont,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: categoryValue[1],
                                                  value: categoryValue[1],
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    groupValue =
                                                        value as String;
                                                    Get.back();
                                                  }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxFont,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: categoryValue[2],
                                                  value: categoryValue[2],
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    groupValue =
                                                        value as String;
                                                    Get.back();
                                                  }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxFont,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: categoryValue[3],
                                                  value: categoryValue[3],
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    groupValue =
                                                        value as String;
                                                    Get.back();
                                                  }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxFont,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: categoryValue[4],
                                                  value: categoryValue[4],
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    groupValue =
                                                        value as String;
                                                    Get.back();
                                                  }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxFont,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===0",
                                                  groupValue: groupValue,
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===1",
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  groupValue: groupValue,
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===2",
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  groupValue: groupValue,
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===3",
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  groupValue: groupValue,
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===4",
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  groupValue: groupValue,
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                                RadioButton(
                                                  contentPadding:
                                                      contentPadding,
                                                  description: "===",
                                                  value: "===5",
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Get.back();
                                                      }),
                                                  groupValue: groupValue,
                                                  activeColor: MainColor.three,
                                                  textStyle: CommunityPageTheme
                                                      .checkBoxDisable,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )),
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
                                    Text(
                                      classificationValue,
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
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.9,
                                      child: SingleChildScrollView(
                                        child: Column(
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
                                              contentPadding:
                                              contentPadding,
                                              description: classValue[0],
                                              value: classValue[0],
                                              groupValue:  classificationValue,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    classificationValue =
                                                    value as String;
                                                    Get.back();
                                                  }),
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxFont,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: classValue[1],
                                              value: classValue[1],
                                              groupValue:   classificationValue,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    classificationValue =
                                                    value as String;
                                                    Get.back();
                                                  }),
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxFont,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: classValue[2],
                                              value: classValue[2],
                                              groupValue:   classificationValue,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    classificationValue =
                                                    value as String;
                                                    Get.back();
                                                  }),
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxFont,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: classValue[3],
                                              value: classValue[3],
                                              groupValue:   classificationValue,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    classificationValue =
                                                    value as String;
                                                    Get.back();
                                                  }),
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxFont,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: classValue[4],
                                              value: classValue[4],
                                              groupValue:   classificationValue,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    classificationValue =
                                                    value as String;
                                                    Get.back();
                                                  }),
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxFont,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===0",
                                              groupValue:   classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===1",
                                              groupValue:   classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===2",
                                              groupValue:   classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===3",
                                              groupValue:  classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===4",
                                              groupValue:   classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                            RadioButton(
                                              contentPadding:
                                              contentPadding,
                                              description: "===",
                                              value: "===5",
                                              groupValue:   classificationValue,
                                              activeColor: MainColor.three,
                                              textStyle: CommunityPageTheme
                                                  .checkBoxDisable,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.white),
                          )),
                          child: TextField(
                              focusNode: titleFocus,
                              controller: _titleController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                fontFamily: "bmPro",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "제목",
                                hintStyle: TextStyle(
                                    fontFamily: "bmPro",
                                    fontSize: 25,
                                    color: Colors.grey),
                              )),
                        ),
                      ],
                    ),
                  ),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: contentCheckKeyBoard(),
                    top: contentPadding,
                    right: contentPadding,
                    left: contentPadding),
                child: HtmlEditor(
                  controller: _controller,
                  callbacks: Callbacks(
                    onFocus: (){ titleFocus.unfocus();}
                  ),
                  otherOptions: OtherOptions(
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
