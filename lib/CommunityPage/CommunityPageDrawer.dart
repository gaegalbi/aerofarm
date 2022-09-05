import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/LoginPage/LoginPageLogin.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../MainPage/MainPageDrawer.dart';
import '../service/getRoute.dart';
import 'CommunityPageForm.dart';

class CommunityPageDrawer extends StatefulWidget {
  const CommunityPageDrawer({Key? key}) : super(key: key);

  @override
  State<CommunityPageDrawer> createState() => _CommunityPageDrawerState();
}

class _CommunityPageDrawerState extends State<CommunityPageDrawer> {
  late ScrollController _scrollController;
  final beforeRouteController = Get.put(BeforeRouteController());
  final nicknameController = Get.put(NicknameController());

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
            backgroundImage: profile!.image,
            /*backgroundImage: const AssetImage("assets/images/profile.png"),*/
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding * 2),
            child: Column(
              children: [
                 Obx(()=>Text(
                   nicknameController.nickname.value,
                  style: nicknameController.nickname.value.length > 7 ? MainScreenTheme.nameSub :MainScreenTheme.name ,
                ),),
                Container(
                    padding: EdgeInsets.only(top: drawerPadding / 2),
                    child: TextButton(
                        child: const Text("내 정보", style: MainScreenTheme.modify),
                        onPressed: () async {
                         /* checkTimerController.time.value ?
                          checkTimerController.stop(context) : await getRoute("CommunityPage");*/
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
                        const Text("공지사항", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore("ANNOUNCEMENT");
                      Get.offAll(()=> CommunityPageForm(category:beforeRouteController.before.value));
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
                            child: const Icon(Icons.local_fire_department,
                                size: 45, color: MainColor.three)),
                        const Text("인기게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore("HOT");
                      Get.offAll(()=> CommunityPageForm(category:beforeRouteController.before.value));
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
                              style: CommunityScreenTheme.all,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Text("전체게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('ALL');
                      Get.offAll(()=>CommunityPageForm(category: beforeRouteController.before.value));
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
                              style: CommunityScreenTheme.free,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Text("자유게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('FREE');
                      Get.offAll(()=>CommunityPageForm(category:   beforeRouteController.before.value));
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
                            child: const Icon(Icons.question_mark,
                                size: 45, color: MainColor.three)),
                        const Text("질문게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('QUESTION');
                      Get.offAll(()=>CommunityPageForm(category: beforeRouteController.before.value));
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
                            child: const Icon(Icons.home,
                                size: 45, color: MainColor.three)),
                        const Text("홈으로", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      Get.off(()=>const MainPage());
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
                        const Text("정보게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('INFORMATION');
                        Get.offAll(()=> CommunityPageForm(category:   beforeRouteController.before.value));
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
                            child: const Icon(Icons.panorama,
                                size: 45, color: MainColor.three)),
                        const Text("사진게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('PICTURE');
                      Get.offAll(()=> CommunityPageForm(category:   beforeRouteController.before.value));
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
                            child: const ImageIcon(
                                AssetImage("assets/images/carrot.png"),
                                size: 45,
                                color: MainColor.three)),
                        const Text("거래게시판", style: MainScreenTheme.drawerButton),
                      ],
                    ),
                    onPressed: () {
                      beforeRouteController.setBefore('TRADE');
                      Get.offAll(()=>CommunityPageForm(category:   beforeRouteController.before.value));
                    },
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
