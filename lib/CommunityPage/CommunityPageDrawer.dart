import 'package:capstone/CommunityPage/CommunityPageHot.dart';
import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/MainPage/MainPageMyProfile.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPageDrawer extends StatefulWidget {
  const CommunityPageDrawer({Key? key}) : super(key: key);

  @override
  State<CommunityPageDrawer> createState() => _CommunityPageDrawerState();
}

class _CommunityPageDrawerState extends State<CommunityPageDrawer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double drawerPadding = MediaQuery.of(context).size.height * 0.007;
    double imageMargin = MediaQuery.of(context).size.width * 0.034;

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.075,
      ),
      color: MainColor.six,
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.25,
            backgroundImage: const AssetImage("assets/images/profile.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding * 2),
            child: Column(
              children: [
                const Text(
                  "도시농부1",
                  style: MainTheme.name,
                ),
                Container(
                    padding: EdgeInsets.only(top: drawerPadding / 2),
                    child: TextButton(
                        child: const Text("내 정보 수정", style: MainTheme.modify),
                        onPressed: () {
                          Get.off(() => const MainPageMyProfile());
                        })),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.58,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const ImageIcon(
                                AssetImage("assets/images/megaphone.png"),
                                size: 45,
                                color: MainColor.three)),
                        const Text("공지사항", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const Icon(Icons.local_fire_department,
                                size: 45, color: MainColor.three)),
                        const Text("인기게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      Get.off(()=> const CommunityPageHot());
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: imageMargin),
                          child: Container(
                            width: 45,
                            height: 25,
                            color: MainColor.three,
                            alignment: Alignment.center,
                            child: const Text(
                              "ALL",
                              style: CommunityPageTheme.all,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Text("전체게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      Get.off(()=> const CommunityPageAll());
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: imageMargin),
                          child: Container(
                            width: 45,
                            height: 25,
                            color: MainColor.three,
                            alignment: Alignment.center,
                            child: const Text(
                              "FREE",
                              style: CommunityPageTheme.free,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Text("자유게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const Icon(Icons.question_mark,
                                size: 45, color: MainColor.three)),
                        const Text("질문게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const Icon(Icons.home,
                                size: 45, color: MainColor.three)),
                        const Text("홈으로", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      Get.off(() => const MainPage());
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const Icon(Icons.info,
                                size: 45, color: MainColor.three)),
                        const Text("정보게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const Icon(Icons.panorama,
                                size: 45, color: MainColor.three)),
                        const Text("사진게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(drawerPadding),
                  child: TextButton(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: imageMargin),
                            child: const ImageIcon(
                                AssetImage("assets/images/carrot.png"),
                                size: 45,
                                color: MainColor.three)),
                        const Text("거래게시판", style: MainTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
