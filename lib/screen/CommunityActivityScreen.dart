import 'package:capstone/screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../themeData.dart';
import '../utils/TabBarDelegate.dart';
import 'MainScreen.dart';

class CommunityActivityScreen extends StatelessWidget {
  const CommunityActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyController = Get.put(KeyController());
    keyController.setKey(GlobalKey<ScaffoldState>());

    final userController = Get.put(UserController());
    final tabController = Get.put(CustomTabController());

    final boardListController = Get.put(BoardListController());
    final commentListController = Get.put(CommentListController());
    final routeController = Get.put(RouteController());
    final loadingController = Get.put(LoadingController());

    loadingController.context = context; //commentWidget에서 NavigatorRoute로 넘기기위해 필요

    Future<bool> _onWillPop() async {
      //textField 비활성
        routeController.setCurrent(Screen.profileCommunity);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>const ProfileScreen()));
      //Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyScreen(board: board)));

      //replyDetailController.replyDetailBefore.value == "ReadPost" ?
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: keyController.scaffoldKey,
        backgroundColor: MainColor.six,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: MainColor.six,
              title: const Text("내 활동", style: MainScreenTheme.title),
              pinned: true,
              leadingWidth: MediaQuery.of(context).size.width * 0.2106,
              leading: Container(
                margin: EdgeInsets.only(left: MainSize.width * 0.05),
                child: FittedBox(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      color: MainColor.three,
                      iconSize: 50,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                      onPressed: () {
                        routeController.setCurrent(Screen.profileCommunity);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>const ProfileScreen()));
                      },
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child:  Container(
                height: MainSize.width*0.5,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text(userController.user.value.nickname, style: CommunityScreenTheme.activityNickname,),
                        CircleAvatar(
                          radius: MainSize.width * 0.12,
                          backgroundImage: userController.user.value.picture?.image,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color:MainColor.one,
                            ),
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextButton(onPressed: () async {
                              /*    checkTimerController.time.value ?
                              checkTimerController.stop(context) : await getRoute("MainPage");*/
                            }, child: const Text("프로필 설정",style: CommunityScreenTheme.activityButton,))),
                        Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color:MainColor.one,
                            ),
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextButton(onPressed: (){}, child: const Text("구매내역",style: CommunityScreenTheme.activityButton))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverPersistentHeader(
              delegate: TabBarDelegate(),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                  controller: tabController.controller,
                  children:[
                    CustomScrollView(
                      //controller: _scrollController,
                      slivers: [
                        Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                          return  boardListController.boardList[index];
                        },childCount: boardListController.boardList.length))),
                      ],
                    ),
                    CustomScrollView(
                     // controller: _scrollController,
                      slivers: [
                        Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                          return  commentListController.commentList[index];
                        },childCount: commentListController.commentList.length))),
                      ],
                    ),
                    CustomScrollView(
                     // controller: _scrollController,
                      slivers: [
                        Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                          return  boardListController.boardList[index];
                        },childCount: boardListController.boardList.length))),
                      ],
                    )
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
