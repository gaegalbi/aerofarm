import 'package:capstone/CommunityPage/CommunityPageReadPost.dart';
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
                Get.offAll(() => const CommunityPageAll());
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
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.04,
              0,
              MediaQuery.of(context).size.width * 0.04,
              MediaQuery.of(context).size.width * 0.04,
            ),
            color: MainColor.six,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: MainColor.one,
                      filled: true,
                      hintStyle: LoginRegisterPageTheme.hint,
                      hintText: "채팅방, 대화내용 검색",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15),
                  alignment: Alignment.centerLeft,
                  child:Text("내채팅",style: CommunityPageTheme.chatTitle,)
                ),
                Container(
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
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(right: 190,bottom: 10),
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
                            Text("도시농부 서비스 너무 좋네요",style: LoginRegisterPageTheme.hint,)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.indigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarButton(
                icon: const Icon(
                  Icons.menu,
                  size: 35,
                ),
                text: const Text(
                  "목록으로",
                  style: CommunityPageTheme.bottomAppBarList,
                ),
                onPressed: () {},
              ),
              Row(
                children: [
                  AppBarButton(
                    icon: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                    text: const Text(
                      "0",
                      style: CommunityPageTheme.bottomAppBarFavorite,
                    ),
                    onPressed: () {
                      Get.to(() => const CommunityPageAll());
                    },
                  ),
                  AppBarButton(
                    icon: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.chat,
                        size: 35,
                      ),
                    ),
                    text: const Text(
                      "0",
                      style: CommunityPageTheme.bottomAppBarReply,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
