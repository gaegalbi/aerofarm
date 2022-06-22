import 'dart:async';
import 'dart:convert';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../CommunityPageCustomLib/CustomRadioButton.dart';
import 'package:http/http.dart' as http;

import '../LoginPage/LoginPageLogin.dart';
import 'CommunityPageForm.dart';

class CommunityPageCreatePost extends StatefulWidget {
  final String id;
  final String type;
  final String title;
  const CommunityPageCreatePost({Key? key, required this.id, required this.type, required this.title}) : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost>
    with TickerProviderStateMixin {
  final List<String> value = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];

  final double floatingBarSize = 60;
  final double contentPadding = 30;
  double contentBottomPadding = 30;

  String groupValue = "게시판 선택";

  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late TextEditingController _titleController;
  late HtmlEditorController _controller;

  var data = <String, dynamic>{};
  final Map<String, String> matchCategory = {
    "자유 게시판":"free",
    "정보 게시판":"information",
    "질문 게시판":"question",
    "사진 게시판" : "picture",
    "거래 게시판":"trade"
  };

  @override
  void initState() {
    _controller = HtmlEditorController();
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    _titleController = TextEditingController();
    super.initState();
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
        return MediaQuery.of(context)
            .viewInsets
            .bottom;
      }else{
      return 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MainSize.toobarHeight / 2,
        elevation: 0,
        backgroundColor: MainColor.six,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            //화면 전환시 키보드 부드럽게 내려가게
            _controller.editorController?.clearFocus();
            _controller.disable();
            Future.delayed(const Duration(microseconds: 1), () {
              Get.offAll(()=>const CommunityPageForm(category:'all'));
            });
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
                onPressed: () async {
                    if(widget.type=="ReadPost"){
                      if(_controller.getText().toString().length==1){//if(_controller.document.toPlainText().length==1){
                        showDialog(context: context, builder: (context){
                          Future.delayed(const Duration(milliseconds: 900), () {
                            Navigator.pop(context);
                          });
                          return const AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.all(5),
                            content: Text("게시판 종류,제목,내용이\n있어야합니다.",style: TextStyle(fontSize: 28),textAlign: TextAlign.center,),
                          );
                        });
                      }else{
                        data = {
                          "category":matchCategory[groupValue],
                          "title":_titleController.text,
                          "contents":_controller.getText(),/*"contents":_controller.document.toPlainText(),*/
                          "postId":widget.id,
                        };
                        var body = json.encode(data);
                        await http.post(
                          Uri.http('127.0.0.1:8080', '/createAnswerPost/${widget.id}'),
                          headers: {
                            "Content-Type": "application/json",
                            "Cookie":"JSESSIONID=$session",
                          },
                          encoding: Encoding.getByName('utf-8'),
                          body: body,
                        );
                        Get.offAll(()=>CommunityPageForm(category: widget.id));
                      }
                    }else{
                      if(matchCategory[groupValue]==null || _titleController.text.isEmpty || _controller.getText().toString().length==1){/*_controller.document.toPlainText().length==1){*/
                        showDialog(context: context, builder: (context){
                          Future.delayed(const Duration(milliseconds: 900), () {
                            Navigator.pop(context);
                          });
                          return const AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.all(5),
                            content: Text("게시판 종류,제목,내용이\n있어야합니다.",style: TextStyle(fontSize: 28),textAlign: TextAlign.center,),
                          );
                        });
                      }else{
                        final txt = await _controller.getText();
                        data = {
                          "category":matchCategory[groupValue],
                          "title":_titleController.text,
                          "contents":txt,
                        };
                        var body = json.encode(data);
                        await http.post(
                          Uri.http('127.0.0.1:8080', '/createBasicPost'),
                          headers: {
                            "Content-Type": "application/json",
                            "Cookie":"JSESSIONID=$session",
                          },
                          encoding: Encoding.getByName('utf-8'),
                          body: body,
                        );
                        Get.offAll(()=>CommunityPageForm(category: widget.id));
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
            widget.type=="ReadPost" ?
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2, color: Colors.white),
                        )),
                    child: TextField(
                        controller: _titleController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontFamily: "bmPro",
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          enabled: false,
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Re : "+widget.title,
                          hintStyle: const TextStyle(
                              fontFamily: "bmPro",
                              fontSize: 25,
                              color: Colors.grey),
                        )),
                  ),
                ],
              ),
            ) :
            SliverToBoxAdapter(child: Column(
                children: [
                  Builder(
                      builder: (context) => TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: null,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.006),
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.white),
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
                                    height: MediaQuery.of(context).size.height *
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
                                            alignment: Alignment.centerLeft,
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
                                            description: value[0],
                                            value: value[0],
                                            groupValue: groupValue,
                                            onChanged: (value) => setState(() {
                                              groupValue = value as String;
                                              Get.back();
                                            }),
                                            activeColor: MainColor.three,
                                            textStyle:
                                                CommunityPageTheme.checkBoxFont,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: value[1],
                                            value: value[1],
                                            groupValue: groupValue,
                                            onChanged: (value) => setState(() {
                                              groupValue = value as String;
                                              Get.back();
                                            }),
                                            activeColor: MainColor.three,
                                            textStyle:
                                                CommunityPageTheme.checkBoxFont,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: value[2],
                                            value: value[2],
                                            groupValue: groupValue,
                                            onChanged: (value) => setState(() {
                                              groupValue = value as String;
                                              Get.back();
                                            }),
                                            activeColor: MainColor.three,
                                            textStyle:
                                                CommunityPageTheme.checkBoxFont,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: value[3],
                                            value: value[3],
                                            groupValue: groupValue,
                                            onChanged: (value) => setState(() {
                                              groupValue = value as String;
                                              Get.back();
                                            }),
                                            activeColor: MainColor.three,
                                            textStyle:
                                                CommunityPageTheme.checkBoxFont,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: value[4],
                                            value: value[4],
                                            groupValue: groupValue,
                                            onChanged: (value) => setState(() {
                                              groupValue = value as String;
                                              Get.back();
                                            }),
                                            activeColor: MainColor.three,
                                            textStyle:
                                                CommunityPageTheme.checkBoxFont,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===0",
                                            groupValue: groupValue,
                                            activeColor: MainColor.three,
                                            textStyle: CommunityPageTheme
                                                .checkBoxDisable,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===1",
                                            groupValue: groupValue,
                                            activeColor: MainColor.three,
                                            textStyle: CommunityPageTheme
                                                .checkBoxDisable,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===2",
                                            groupValue: groupValue,
                                            activeColor: MainColor.three,
                                            textStyle: CommunityPageTheme
                                                .checkBoxDisable,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===3",
                                            groupValue: groupValue,
                                            activeColor: MainColor.three,
                                            textStyle: CommunityPageTheme
                                                .checkBoxDisable,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===4",
                                            groupValue: groupValue,
                                            activeColor: MainColor.three,
                                            textStyle: CommunityPageTheme
                                                .checkBoxDisable,
                                          ),
                                          RadioButton(
                                            contentPadding: contentPadding,
                                            description: "===",
                                            value: "===5",
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2, color: Colors.white),
                    )),
                    child: TextField(
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
              ),),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: contentCheckKeyBoard(),
                    top: contentPadding,
                    right: contentPadding,
                    left: contentPadding),
                child: HtmlEditor(
                  controller: _controller,
                  otherOptions: OtherOptions(
                    height:MediaQuery.of(context).size.height,
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