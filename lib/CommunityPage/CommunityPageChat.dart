import 'package:bubble/bubble.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import '../CurrentTime.dart';

class CommunityPageChat extends StatefulWidget {
  const CommunityPageChat({Key? key}) : super(key: key);

  @override
  State<CommunityPageChat> createState() => _CommunityPageChatState();
}

class _CommunityPageChatState extends State<CommunityPageChat> {
  late TextEditingController _textEditingController;
  late final List<Widget> _chatList = [];

  @override
  void initState() {
    _chatList.clear();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _chatList.clear();
    _textEditingController.dispose();
    super.dispose();
  }

  void addChat(bool mine, String text) {
    _chatList.add(
      AddChat(mine: mine, text: _textEditingController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toobarHeight,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: FittedBox(
                child: IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              color: MainColor.three,
              iconSize: 50,
              // 패딩 설정
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.chevron_left,
              ),
              onPressed: () {},
            )),
          ),
          title: const Text("city", style: MainTheme.title),
          actions: [
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: MainColor.six,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                children: _chatList,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -MediaQuery.of(context).viewInsets.bottom),
          child: BottomAppBar(
            color: Colors.indigo,
            child: Container(
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: _textEditingController,
                      textInputAction: TextInputAction.next,
                      style: LoginRegisterPageTheme.text,
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "메시지를 입력하세요",
                          hintStyle: LoginRegisterPageTheme.hint),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 35,
                        ),
                        onPressed: () {},
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MainColor.one)),
                        child: const Text(
                          "보내기",
                          style: CommunityPageTheme.bottomAppBarList,
                        ),
                        onPressed: () {
                          setState(() {
                            addChat(false, _textEditingController.text);
                            _textEditingController.text = "";
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class AddChat extends StatelessWidget {
  final bool mine;
  final String text;

  const AddChat({Key? key, required this.mine, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mine) {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CurrentTime(type: false, style: "default"),
            Bubble(
              alignment: Alignment.centerRight,
              color: MainColor.three,
              child: Text(text, style: CommunityPageTheme.chatContent),
              nip: BubbleNip.rightTop,
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bubble(
              alignment: Alignment.centerLeft,
              color: MainColor.one,
              child: Text(text, style: CommunityPageTheme.chatContent),
              nip: BubbleNip.leftTop,
            ),
            CurrentTime(type: false, style: "default"),
          ],
        ),
      );
    }
  }
}
