import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import '../CommunityPageCustomLib/CustomQuillToolbar.dart';

class CommunityPageCreatePost extends StatefulWidget {
  const CommunityPageCreatePost({Key? key}) : super(key: key);

  @override
  State<CommunityPageCreatePost> createState() =>
      _CommunityPageCreatePostState();
}

class _CommunityPageCreatePostState extends State<CommunityPageCreatePost>
    with TickerProviderStateMixin {
  final List<String> value = ["자유 게시판", "질문 게시판", "정보 게시판", "사진 게시판", "거래 게시판"];
  final List<String> fontSizesName = ["Small", "Large", "Huge"];
  final List<double> fontSizes = [20, 26, 32];

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
  bool control = false;
  bool popup = false;
  int floatingAlignButtonIndex = 0;
  int fontSizeIndex = 0;
  String fontBold = 'bmAir';
  bool isBold = false;

  late quill.QuillController _controller;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late final FocusNode focusNode;

  @override
  void initState() {
    _controller = quill.QuillController(
      document: quill.Document(),
      selection: const TextSelection.collapsed(offset: 0)
      //not working
      ,keepStyleOnNewLine: true,);

    _scrollController = ScrollController();
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
        return MediaQuery.of(context).viewInsets.bottom;//MediaQuery.of(context).viewInsets.bottom;
      }
    } else {
      //print(_scrollController.position.maxScrollExtent );
      if (popup) {
        if(_scrollController1.position.maxScrollExtent >0){
          return floatingBarSize*1.5;
        }else {
          return floatingBarSize; //floatingBarSize;
        }
      } else {
        return contentPadding;
      }
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
            focusNode.unfocus();
            Future.delayed(const Duration(microseconds: 1), () {
              Get.offAll(const CommunityPageAll());
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
      body: Container(
        color: MainColor.six,
        child: CustomScrollView(
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
                  controller: _controller,//_editorController,
                  autoFocus: false,
                  expands: false,
                  padding: const EdgeInsets.all(0),//EdgeInsets.all(20),
                  scrollable: true,
                  readOnly: false,
                  minHeight: MediaQuery.of(context).size.height * 0.59,//0.626,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: floatingBarSize,
        margin: EdgeInsets.only(bottom: floatingMargin()),
        child: popup
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: MainColor.one),
                  ),
                ),
                child: CustomQuillToolbar.basic(
                  showLink: false,
                  controller: _controller,//_toolbarController,
                  multiRowsDisplay: false,
                  iconTheme: const quill.QuillIconTheme(
                      iconUnselectedFillColor: MainColor.six,
                      iconUnselectedColor: MainColor.three,
                      iconSelectedColor: Colors.white,
                      iconSelectedFillColor: MainColor.one),
                ),
              )
            : null,
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, checkKeyBoard()),
        child: BottomAppBar(
            color: MainColor.three,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const ImageIcon(
                      AssetImage("assets/images/letter-t-.png"),
                    ),
                    onPressed: () {
                      setState(() {
                        popup = !popup;
                        print(popup);
                        //팝업후 입력시 바로 포커스 가긴 하는데 입력 전에 바로 가야 매끄러울듯
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
                      AssetImage("assets/images/link.png"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
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
  final double contentPadding;

  const RadioButton(
      {Key? key,
      required this.description,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.activeColor,
      this.textStyle,
      required this.contentPadding})
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