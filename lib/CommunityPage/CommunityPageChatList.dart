import 'package:capstone/CommunityPage/CommunityPageChat.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CurrentTime.dart';
import 'CommunityPageAll.dart';

class CommunityPageChatList extends StatefulWidget {
  const CommunityPageChatList({Key? key}) : super(key: key);

  @override
  State<CommunityPageChatList> createState() => _CommunityPageChatListState();
}

class _CommunityPageChatListState extends State<CommunityPageChatList> {
  late FocusNode _focusTextField;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _focusTextField = FocusNode();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusTextField.dispose();
    _textEditingController.dispose();
    super.dispose();
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
            onPressed: () {
              Get.offAll(const CommunityPageAll());
            },
          )),
        ),
        title: const Text("도시농부", style: MainTheme.title),
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
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusTextField,
                    decoration: InputDecoration(
                      prefixIcon: _focusTextField.hasFocus
                          ? const Icon(
                              Icons.search,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                      suffixIcon: _focusTextField.hasFocus
                          ? IconButton(
                              onPressed: () {
                                _textEditingController.text = "";
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                      fillColor: MainColor.one,
                      filled: true,
                      hintStyle: LoginRegisterPageTheme.hint,
                      hintText: "채팅방, 대화내용 검색",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 15, top: 15),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "내채팅",
                      style: CommunityPageTheme.chatTitle,
                    )),
                MaterialButton(
                  onPressed: () {
                    Get.to(()=>const CommunityPageChat());
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.01),
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2, color: Colors.white),
                    )),
                    child: Row(
                      children: [
                        //프로필
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.08,
                          backgroundImage:
                              const AssetImage("assets/images/profile.png"),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.02,
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 190, bottom: 10),
                                    child: const Text(
                                      "city",
                                      style: CommunityPageTheme.postFont,
                                    ),
                                  ),
                                  const CurrentTime(
                                    type: true,
                                    style: 'korean',
                                  ),
                                ],
                              ),
                              Text(
                                "도시농부 서비스 너무 좋네요",
                                style: LoginRegisterPageTheme.hint,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
