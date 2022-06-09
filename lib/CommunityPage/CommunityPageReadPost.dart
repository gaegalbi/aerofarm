import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/CommunityPage/CommunityPageReply.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CurrentTime.dart';

class CommunityPageReadPost extends StatefulWidget {
  const CommunityPageReadPost({Key? key}) : super(key: key);

  @override
  State<CommunityPageReadPost> createState() => _CommunityPageReadPostState();
}

class _CommunityPageReadPostState extends State<CommunityPageReadPost> {
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
                Get.offAll( const CommunityPageAll());
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
                  onPressed: () {
                    Get.offAll( const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.04,
              0,
              MediaQuery.of(context).size.width * 0.04,
              MediaQuery.of(context).size.width * 0.04,
            ),
            color: MainColor.six,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.03,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "전체게시판",
                          style: CommunityPageTheme.title,
                        ),
                        IconButton(
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          color: MainColor.three,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.chevron_right,
                          ),
                          onPressed: () {
                            Get.offAll( const CommunityPageAll());
                          },
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.012),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "도시농부 서비스 좋네여",
                        style: CommunityPageTheme.postTitle,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.03,
                      left: MediaQuery.of(context).size.width * 0.03),
                  child: Column(
                    children: [
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
                                  right:
                                      MediaQuery.of(context).size.width * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: const Text(
                                            "city",
                                            style: CommunityPageTheme.postFont,
                                          )),
                                      SizedBox(
                                        width: 54,
                                        height: 30,
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Row(
                                              children: const [
                                                Icon(
                                                  Icons.chat,
                                                  color: MainColor.three,
                                                ),
                                                Text(
                                                  "채팅",
                                                  style: CommunityPageTheme.postButton,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: const CurrentTime(
                                          type: true,
                                          style: 'normal',
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: const CurrentTime(
                                          type: false,
                                          style: 'normal',
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Text("조회 2222"))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01),
                        child: Column(
                          children: [
                            //본문
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("하이")),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Contrary to popular belief, Lorem Ipsum is not "
                                "simply random text. It has roots in a piece of clas"
                                "sical Latin literature from 45 BC, making it over 2"
                                "000 years old. Richard McClintock, a Latin professor at"
                                " Hampden-Sydney College in Virginia, looked up one of "
                                "the more obscure Latin words, consectetur, from a Lorem I"
                                "psum passage, and going through the cites of the word in classic"
                                "al literature, discovered the undoubtable source. Lor"
                                "em Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Fini"
                                "bus Bonorum et Malorum\" (The Extremes of Good and Evil) by C"
                                "icero, written in 45 BC. This book is a treatise on the theory"
                                " of ethics, very popular during the Renaissance. The first line "
                                "of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a "
                                "line in section 1.10.32.The standard chunk of Lorem Ipsum used "
                                "since the 1500s is reproduced below for those interested. Sectio"
                                "ns 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by"
                                " Cicero are also reproduced in their exact original form, accompa"
                                "nied by English versions from the 1914 translation by H.Rackham.",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Image.asset("assets/images/dog.png")
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(width: 2, color: Colors.white),
                          )),
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: const Text(
                                        "댓글",
                                        style: CommunityPageTheme.postFont,
                                      ),
                                    ),
                                    const Text(
                                      "0",
                                      style: CommunityPageTheme.postFont,
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Get.to(()=>const CommunityPageReply());
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        backgroundImage: const AssetImage(
                                            "assets/images/profile.png"),
                                      ),
                                    ),
                                    const Text(
                                      "첫 댓글을 입력하세요",
                                      style: CommunityPageTheme.postFont,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
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
                      Get.to(()=>const CommunityPageAll());
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
                    onPressed: () {
                      Get.to(()=>const CommunityPageReply());
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

@immutable
class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}

/*
*/
/*

BottomNavigationBar(
backgroundColor: MainColor.three,
items: <BottomNavigationBarItem>[
BottomNavigationBarItem(
icon: Row(
children: const [
Icon(Icons.menu),
Text(
"목록으로",
style: Community.bottomAppBarList,
)
],
),
label: '',
),
BottomNavigationBarItem(
icon: Row(
children: const [
Icon(Icons.menu),
Text(
"목록으로",
style: Community.bottomAppBarList,
)
],
),
label: '',
),
BottomNavigationBarItem(
icon: Row(
children: const [
Icon(Icons.menu),
Text(
"목록으로",
style: Community.bottomAppBarList,
)
],
),
label: '',
),
],
)*/
