import 'dart:async';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CustomQuillToolbar.dart';
import '../CommunityPageCustomLib/CustomRadioButton.dart';
import 'package:http/http.dart' as http;

import 'CommunityPageForm.dart';

class CommunityPageCreatePost extends StatefulWidget {
  const CommunityPageCreatePost({Key? key}) : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost>
    with TickerProviderStateMixin {
  final List<String> value = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];

  final List<Icon> floatingAlignButton = const [
    Icon(
      Icons.format_align_left,
      color: Colors.white,
    ),
    Icon(
      Icons.format_align_center,
      color: Colors.white,
    ),
    Icon(
      Icons.format_align_right,
      color: Colors.white,
    )
  ];
  final double floatingBarSize = 60;
  final double contentPadding = 30;
  double contentBottomPadding = 30;

  String groupValue = "게시판 선택";
  bool popupFont = false;
  bool popupImage = false;
  bool popupLink = false;
  bool popupTag = false;
  bool popup = false;

  late quill.QuillController _controller;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late TextEditingController _textEditingController;
  late final FocusNode focusNode;

  quill.OnImagePickCallback? onImagePickCallback;
  quill.OnVideoPickCallback? onVideoPickCallback;
  quill.MediaPickSettingSelector? mediaPickSettingSelector;
  quill.FilePickImpl? filePickImpl;
  quill.WebImagePickImpl? webImagePickImpl;
  quill.WebVideoPickImpl? webVideoPickImpl;

/*  Future<http.Response> _postRequest(String title,String writer, String category) {
    return http.post(
      Uri.http('172.25.2.57:8080', '/community/createPost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'writer' : writer,
        'category' : category
      }),
    );
  }*/
/*

  void _postRequest(String title, String writer,String category) async {
    http.Response response = await http.post(
      Uri.http('172.25.2.57:8080', '/community/createPost'),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      //headers: {"Content-Type": "application/json"},
      body: SendPost(title: title, writer: writer, category: category),
    );
    print("work");
  }

*/

  @override
  void initState() {
    _controller = quill.QuillController(
      document: quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),
      keepStyleOnNewLine: true, //not working
    );
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    _textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _scrollController1.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  double checkKeyBoard() {
    if (MediaQuery.of(context).viewInsets.bottom >
        MediaQuery.of(context).size.height * 0.049) {
      return -MediaQuery.of(context).viewInsets.bottom + 30; //바텀 네비게이션바 높이
    } else {
      return 0;
    }
  }

  double floatingMargin() {
    if (MediaQuery.of(context).viewInsets.bottom > floatingBarSize) {
      return MediaQuery.of(context).viewInsets.bottom +
          (floatingBarSize + MediaQuery.of(context).size.height) * 0.02;
    } else {
      return floatingBarSize;
    }
  }

  double contentCheckKeyBoard() {
    if (MediaQuery.of(context).viewInsets.bottom > 0 && focusNode.hasFocus) {
      if (popup) {
        return floatingBarSize + MediaQuery.of(context).viewInsets.bottom;
      } else {
        return MediaQuery.of(context)
            .viewInsets
            .bottom; //MediaQuery.of(context).viewInsets.bottom;
      }
    } else {
      if (popup) {
        if (_scrollController1.position.maxScrollExtent > 0) {
          return floatingBarSize * 1.5;
        } else {
          return floatingBarSize; //floatingBarSize;
        }
      } else {
        return contentPadding;
      }
    }
  }

  /*void addBoard(String content, AssetImage image, String user) {
    boardList.add(
       AddBoard()
    );
  }*/

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
            focusNode.unfocus();
            Future.delayed(const Duration(microseconds: 1), () {
              Get.off(()=>const CommunityPageForm(category:'all'));
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
                /*  Future<http.Response> fetchPost() {
                    return http.post(
                      Uri.http('172.25.2.57:8080', '/community/test123'),
                      // 백엔드에 Authorization 헤더를 보냅니다.
                      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
                    );
                  }*/
                  http.Response _res = await http.get(
                    Uri.http('172.25.2.57:8080', '/login'),
                  );
                  print(_res.body);
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
            SliverToBoxAdapter(
              child: Column(
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
                    child: const TextField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontFamily: "bmPro",
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
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
                child: quill.QuillEditor(
                  keyboardAppearance: Brightness.dark,
                  textCapitalization: TextCapitalization.none,
                  focusNode: focusNode,
                  scrollController: _scrollController,
                  controller: _controller,
                  //_editorController,
                  autoFocus: false,
                  expands: false,
                  padding: const EdgeInsets.all(0),
                  //EdgeInsets.all(20),
                  scrollable: true,
                  readOnly: false,
                  minHeight: MediaQuery.of(context).size.height * 0.59, //0.626,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          decoration: popup ? const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: MainColor.one),
            ),
          ) : null,
          width: MediaQuery.of(context).size.width,
          height: floatingBarSize,
          margin: EdgeInsets.only(bottom : floatingMargin()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              popupFont
                  ? CustomQuillToolbar.basic(
                    toolbarHeight: 30,
                    showLink: false,
                    controller: _controller,
                    //_toolbarController,
                    multiRowsDisplay: false,
                    showImageButton: false,
                    showVideoButton: false,
                    iconTheme: const quill.QuillIconTheme(
                        iconUnselectedFillColor: MainColor.six,
                        iconUnselectedColor: MainColor.three,
                        iconSelectedColor: Colors.white,
                        iconSelectedFillColor: MainColor.one),
                  )
                  : SizedBox.shrink(),
              popupImage
                  ? CustomQuillToolbar.basic(
                  toolbarHeight: 30,
                  showLink: false,
                  showUndo: false,
                  showRedo: false,
                  showRightAlignment: false,
                  showCenterAlignment: false,
                  showLeftAlignment: false,
                  showListNumbers: false,
                  showListCheck: false,
                  showListBullets: false,
                  showQuote: false,
                  showJustifyAlignment: false,
                  showInlineCode: false,
                  showIndent: false,
                  showFontSize: false,
                  showDirection: false,
                  showBoldButton: false,
                  showItalicButton: false,
                  showUnderLineButton: false,
                  showClearFormat: false,
                  showColorButton: false,
                  showHeaderStyle: false,
                  showBackgroundColorButton: false,
                  showCodeBlock: false,
                  showStrikeThrough: false,
                  controller: _controller,
                  //_toolbarController,
                  multiRowsDisplay: false,
                  showImageButton: true,
                  showVideoButton: true,
                  iconTheme: const quill.QuillIconTheme(
                      iconUnselectedFillColor: MainColor.six,
                      iconUnselectedColor: MainColor.three,
                      iconSelectedColor: Colors.white,
                      iconSelectedFillColor: MainColor.one),
              )
                  :  SizedBox.shrink(),
            ],
          )),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, checkKeyBoard()),
        child: BottomAppBar(
            color: MainColor.three,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.text_fields,
                        size: 35,
                        color: popupFont ? MainColor.six : Colors.white),
                    onPressed: () {
                      setState(() {
                        if (popupImage || popupLink) {
                          popupImage= false;
                          popupLink = false;
                        }
                        if(!popupFont){
                          popupFont = true;
                        }else{
                          popupFont = false;
                        }
                        if(popupFont || popupImage || popupLink){
                          popup = true;
                        }
                        if(!popupFont && !popupImage && !popupLink){
                          popup = false;
                        }
                        //팝업후 editor 입력시 바로 포커스 가긴 하는데 입력 전에 바로 가야 매끄러울듯
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt,
                        size: 35,
                        color: popupImage? MainColor.six : Colors.white),
                    onPressed: () {
                      setState(() {
                        if (popupFont || popupLink) {
                          popupFont = false;
                          popupLink = false;
                        }
                        if(!popupImage){
                          popupImage = true;
                        }else{
                          popupImage = false;
                        }
                        if(popupFont || popupImage || popupLink){
                          popup = true;
                        }
                        if(!popupFont && !popupImage && !popupLink){
                          popup = false;
                        }
                        //팝업후 editor 입력시 바로 포커스 가긴 하는데 입력 전에 바로 가야 매끄러울듯
                      });
                    },
                  ),
                  quill.LinkStyleButton(
                    controller: _controller,
                    iconSize: 35,
                    iconTheme: const quill.QuillIconTheme(
                        iconUnselectedFillColor: MainColor.three,
                        iconUnselectedColor: Colors.white,
                        iconSelectedColor: Colors.white,
                        iconSelectedFillColor: MainColor.three),
                  ),
                ])),
      ),
    );
  }
}