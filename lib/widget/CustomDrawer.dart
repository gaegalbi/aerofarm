import 'package:capstone/model/BoardType.dart';
import 'package:capstone/model/Screen.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityActivityScreen.dart';
import 'package:capstone/screen/CommunityScreen.dart';
import 'package:capstone/screen/DeviceListScreen.dart';
import 'package:capstone/screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../screen/LoginScreen.dart';
import '../screen/MainScreen.dart';
import '../service/getMyComment.dart';
import '../service/getMyPost.dart';
import '../themeData.dart';

class CustomMainDrawer extends StatelessWidget {
  const CustomMainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double drawerPadding = MediaQuery.of(context).size.height*0.01;
    final userController = Get.put(UserController());
    final tabController = Get.put(CustomTabController());
    final floatingController = Get.put(FloatingController());
    final routeController = Get.put(RouteController());

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
      color: MainColor.six,
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width*0.22,
            backgroundImage: userController.user.value.picture?.image,
            /*backgroundImage: const AssetImage("assets/images/profile.png"),*/
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding*2),
            alignment: Alignment.center,
            child: Column(
              children: [
                Obx(()=>Text(
                  userController.user.value.nickname,
                  style: userController.user.value.nickname.length >7 ?  MainScreenTheme.nameSub : MainScreenTheme.name,
                )),
                Container(
                    padding:  EdgeInsets.only(top: drawerPadding/2),
                    child: TextButton(
                        child: const Text("내 정보",
                            style: MainScreenTheme.modify),
                        onPressed: () async {
                          floatingController.setUp();
                          routeController.setCurrent(Screen.profileMain);
                          checkTimerController.time.value ?
                          checkTimerController.stop(context) : Get.to(()=>const ProfileScreen());
                        }
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("소유한 기기 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                Get.to(()=>const DeviceListScreen());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                routeController.isMain.value = true;
                routeController.setCurrent(Screen.activity);

                tabController.controller.index = 0;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :    getMyPostStart().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityActivityScreen())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 댓글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                routeController.isMain.value = true;
                routeController.setCurrent(Screen.activity);

                tabController.controller.index = 1;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :    getMyCommentStart().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityActivityScreen())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("좋아요한 글 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {
                routeController.isMain.value = true;
                routeController.setCurrent(Screen.activity);

                tabController.controller.index = 2;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :    getMyLikePostStart().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityActivityScreen())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("구매내역 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("재배한 작물 조회", style: MainScreenTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("로그아웃", style: MainScreenTheme.drawerButton),
              onPressed: () {
                Get.offAll(()=>const LoginScreen(reLogin: false,));
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomCommunityDrawer extends StatelessWidget {
  const CustomCommunityDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double drawerPadding = MainSize.height*0.01;
    double imageMargin = MainSize.width * 0.034;
    final userController = Get.put(UserController());
    final floatingController = Get.put(FloatingController());
    final routeController = Get.put(RouteController());

    return Container(
      width: MainSize.width * 0.75,
      padding: EdgeInsets.only(
        top: MainSize.height * 0.075,
      ),
      color: MainColor.six,
      child: Column(
        children: [
          CircleAvatar(
            radius: MainSize.width * 0.25,
            backgroundImage: userController.user.value.picture?.image,
            /*backgroundImage: const AssetImage("assets/images/profile.png"),*/
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding * 2),
            child: Column(
              children: [
                Obx(()=>Text(
                  userController.user.value.nickname,
                  style:   userController.user.value.nickname.length > 7 ? MainScreenTheme.nameSub :MainScreenTheme.name ,
                ),),
                Container(
                    padding: EdgeInsets.only(top: drawerPadding / 2),
                    child: TextButton(
                        child: const Text("내 정보", style: MainScreenTheme.modify),
                        onPressed: () async {
                          floatingController.setUp();
                          routeController.setCurrent(Screen.profileCommunity);
                          checkTimerController.time.value ?
                          checkTimerController.stop(context) : Get.to(()=>const ProfileScreen());
                        })),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.58,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              //controller: _scrollController,
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
                      routeController.setBoardType(BoardType.announcement);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.announcement));
                      //beforeRouteController.setBefore("ANNOUNCEMENT");
                     // Get.offAll(()=> CommunityPageForm(category:beforeRouteController.before.value));
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
                      routeController.setBoardType(BoardType.hot);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.hot));
                      /*beforeRouteController.setBefore("HOT");
                      Get.offAll(()=> CommunityPageForm(category:beforeRouteController.before.value));*/
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
                      routeController.setBoardType(BoardType.all);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.all));
                     /* beforeRouteController.setBefore('ALL');
                      Get.offAll(()=>CommunityPageForm(category: beforeRouteController.before.value));*/
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
                      routeController.setBoardType(BoardType.free);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.free));
                     /* beforeRouteController.setBefore('FREE');
                      Get.offAll(()=>CommunityPageForm(category:   beforeRouteController.before.value));*/
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
                      routeController.setBoardType(BoardType.question);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.question));
                     /* beforeRouteController.setBefore('QUESTION');
                      Get.offAll(()=>CommunityPageForm(category: beforeRouteController.before.value));*/
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
                      Get.off(()=>const MainScreen());
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
                      routeController.setBoardType(BoardType.info);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.info));
                    /*  beforeRouteController.setBefore('INFORMATION');
                      Get.offAll(()=> CommunityPageForm(category:   beforeRouteController.before.value));*/
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
                      routeController.setBoardType(BoardType.picture);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.picture));
                     /* beforeRouteController.setBefore('PICTURE');
                      Get.offAll(()=> CommunityPageForm(category:   beforeRouteController.before.value));*/
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
                      routeController.setBoardType(BoardType.trade);
                      Get.offAll(()=>const CommunityScreen(boardType: BoardType.trade));
                     /* beforeRouteController.setBefore('TRADE');
                      Get.offAll(()=>CommunityPageForm(category:   beforeRouteController.before.value));*/
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

