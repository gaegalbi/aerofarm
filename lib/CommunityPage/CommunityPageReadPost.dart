import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  onPressed: () {
                    Get.offAll(() => const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        body: Container(
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
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "전체게시판",
                        style: Community.title,
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
                            Get.offAll(() => const CommunityPageAll());
                          },
                        )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.014,
                ),
                height: MediaQuery.of(context).size.height * 0.6146,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.01),
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                      )),
                      child: InkWell(
                        onTap: () {
                          //Get.off(()=>const MachinePageInfo());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.64,
                                    margin: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.008),
                                            child: Text(
                                              "도시농부 서비스 좋네여 $index",
                                              style: Community.main,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "city",
                                              style: Community.sub,
                                            ),
                                            const Text(
                                              "2022-05-08",
                                              style: Community.sub,
                                            ),
                                            Text(
                                              "조회 $index",
                                              style: Community.sub,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "추천 ",
                                                  style: Community.sub,
                                                ),
                                                Text(
                                                  "$index",
                                                  style: Community.sub1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.048,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "$index",
                                      style: Community.main,
                                      textAlign: TextAlign.center,
                                    ),
                                    decoration: BoxDecoration(
                                        color: MainColor.one,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
                  style: Community.bottomAppBarList,
                ),
                onPressed: () {},
              ),
              Row(
                children: [
                  AppBarButton(
                    icon: const Icon(
                      Icons.favorite_outline,
                      size: 35,
                      color: Colors.red,
                    ),
                    text: const Text(
                      "7777",
                      style: Community.bottomAppBarFavorite,
                    ),
                    onPressed: () {},
                  ),
                  AppBarButton(
                    icon: const Icon(
                      Icons.chat,
                      size: 35,
                    ),
                    text: const Text(
                      "0",
                      style: Community.bottomAppBarReply,
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
