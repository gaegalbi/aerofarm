import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:get/get.dart';

class CommunityPageCreatePost extends StatefulWidget {
  const CommunityPageCreatePost({Key? key}) : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost>
    with TickerProviderStateMixin {
  final List<String> value = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];
  final List<int> fontSizes = [18, 24, 30];
  String groupValue = "게시판 선택";
  bool control = false;
  bool popup = false;
  final double floatingBarSize = 40;
  final List<Icon> floatingAlignButton = const [Icon(Icons.format_align_left,color: Colors.white,),Icon(Icons.format_align_center,color: Colors.white,),Icon(Icons.format_align_right,color: Colors.white,)];
  int floatingAlignButtonIndex = 0;
  /*
  late final AnimationController _AnimationController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  );*/

  late quill.QuillController _controller;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late final FocusNode focusNode;

  @override
  void initState() {
    _controller = quill.QuillController.basic();
    _scrollController = ScrollController();
    //body
    _scrollController1 = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _scrollController1.dispose();
    super.dispose();
  }

  double checkKeyBoard() {
    if (MediaQuery.of(context).viewInsets.bottom > 40) {
      return -MediaQuery.of(context).viewInsets.bottom + 30;
    } else {
      return 0;
    }
  }

  double floatingMargin(){
    if(MediaQuery.of(context).viewInsets.bottom > 40){
      return  MediaQuery.of(context).viewInsets.bottom + floatingBarSize/2-1;
    }else{
      return floatingBarSize;
    }
  }

  double contentCheckKeyBoard() {
    if (MediaQuery.of(context).viewInsets.bottom > 0 &&
        focusNode.hasFocus &&
        _scrollController1.position.maxScrollExtent >=
            MediaQuery.of(context).size.height * 0.1) {
      //print(_scrollController1.position.maxScrollExtent);
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
        toolbarHeight: MainSize.toobarHeight / 2,
        elevation: 0,
        backgroundColor: MainColor.six,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            focusNode.unfocus();
            Future.delayed(const Duration(microseconds: 1), () {
              Get.offAll(() => const CommunityPageAll());
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
                onPressed: () {},
                child: const Text(
                  "등록",
                  style: CommunityPageTheme.postFont,
                )),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          reverse: true,
          controller: _scrollController1,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: contentCheckKeyBoard()),
              color: MainColor.six, //colors.whtie,
              //height: MediaQuery.of(context).size.height,
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
                                bottom:
                                    MediaQuery.of(context).size.height * 0.006),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
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
                                          description: "===",
                                          value: "===0",
                                          groupValue: groupValue,
                                          activeColor: MainColor.three,
                                          textStyle: CommunityPageTheme
                                              .checkBoxDisable,
                                        ),
                                        RadioButton(
                                          description: "===",
                                          value: "===1",
                                          groupValue: groupValue,
                                          activeColor: MainColor.three,
                                          textStyle: CommunityPageTheme
                                              .checkBoxDisable,
                                        ),
                                        RadioButton(
                                          description: "===",
                                          value: "===2",
                                          groupValue: groupValue,
                                          activeColor: MainColor.three,
                                          textStyle: CommunityPageTheme
                                              .checkBoxDisable,
                                        ),
                                        RadioButton(
                                          description: "===",
                                          value: "===3",
                                          groupValue: groupValue,
                                          activeColor: MainColor.three,
                                          textStyle: CommunityPageTheme
                                              .checkBoxDisable,
                                        ),
                                        RadioButton(
                                          description: "===",
                                          value: "===4",
                                          groupValue: groupValue,
                                          activeColor: MainColor.three,
                                          textStyle: CommunityPageTheme
                                              .checkBoxDisable,
                                        ),
                                        RadioButton(
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
                Container(
                  //height: MediaQuery.of(context).size.height * 0.68,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: quill.QuillEditor(
                    keyboardAppearance: Brightness.dark,
                    textCapitalization: TextCapitalization.none,
                    focusNode: focusNode,
                    scrollController: _scrollController,
                    controller: _controller,
                    autoFocus: false,
                    expands: false,
                    padding: const EdgeInsets.all(30),
                    scrollable: true,
                    readOnly: false,
                    minHeight: MediaQuery.of(context).size.height * 0.626,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: floatingBarSize,

        margin: EdgeInsets.only(bottom: floatingMargin()),
        child : popup ? Container(
          color: MainColor.one,
          child: Row(
              children: [
                TextButton(onPressed: () { },
                  child: Text("Font",style: CommunityPageTheme.floatingButton,),
                ),
                TextButton(
                  onPressed: () {
                    setState((){
                    if(floatingAlignButtonIndex==floatingAlignButton.length-1) {
                      floatingAlignButtonIndex = 0;
                    }else{
                      floatingAlignButtonIndex++;
                    }
                    });
                },
                  child: floatingAlignButton[floatingAlignButtonIndex],
                ),
              ],),
        ): null,
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, checkKeyBoard()),
        child: BottomAppBar(
            color: MainColor.three,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage("assets/images/letter-t-.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      popup = !popup;
                      print(popup);
                    });
                    //fontsize, boldbutton, Italic, underline, color, left, center, right alignment
                  },
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/images/link.png"),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/images/hash.png"),
                  ),
                ),
              ])),
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

/*
quill.QuillToolbar.basic(
controller: _controller,
customIcons: [
quill.QuillCustomIcon(
icon: Icons.abc,
onTap: (){

},
)
],

showDividers: control,
showFontSize: control,
showBoldButton: control,
showItalicButton: control,
showSmallButton: control,
showUnderLineButton: control,
showStrikeThrough:control,
showInlineCode: control,
showColorButton: control,
showBackgroundColorButton: control,
showClearFormat: control,
showAlignmentButtons: control,
showLeftAlignment: control,
showCenterAlignment: control,
showRightAlignment: control,
showJustifyAlignment: control,
showHeaderStyle:control,
showListNumbers:control,
showListBullets:control,
showListCheck: control,
showCodeBlock: control,
showQuote: control,
showIndent: control,
showLink: control,
showUndo: control,
showRedo:control,
multiRowsDisplay: control,
showImageButton:control,
showVideoButton: control,
showCameraButton: control,
showDirection: control,
*/
/* showDividers: true,
          showFontSize: true,
          showBoldButton: true,
          showItalicButton: true,
          showSmallButton: false,
          showUnderLineButton: true,
          showStrikeThrough: true,
          showInlineCode: true,
          showColorButton: true,
          showBackgroundColorButton: true,
          showClearFormat: true,
          showAlignmentButtons: false,
          showLeftAlignment: true,
          showCenterAlignment: true,
          showRightAlignment: true,
          showJustifyAlignment: true,
          showHeaderStyle: true,
          showListNumbers: true,
          showListBullets: true,
          showListCheck: true,
          showCodeBlock: true,
          showQuote: true,
          showIndent: true,
          showLink: true,
          showUndo: true,
          showRedo: true,
          multiRowsDisplay: true,
          showImageButton: true,
          showVideoButton: true,
          showCameraButton: true,
          showDirection: false,*/ /*

),*/

/*
Transform.translate(
offset: Offset(0.0, popup ? checkKeyBoard() -_scrollController1.offset : 0),
child: Row(
children: [
FloatingActionButton(onPressed: () {    print(popup); },child: Text("Middle"),


),
],
),
),*/
