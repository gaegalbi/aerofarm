import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/LoginPage/LoginPageLogin.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MainPage/MainPageDrawer.dart';
import '../themeData.dart';

class KeyController extends GetxController{
  late GlobalKey<ScaffoldState> scaffoldKey;

  void setKey(GlobalKey<ScaffoldState> key){
    scaffoldKey = key;
  }
}

class CommunityPageMyActivity extends StatelessWidget {
  const CommunityPageMyActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyController = Get.put(KeyController());
    keyController.setKey(GlobalKey<ScaffoldState>());

    final boardListController = Get.put(BoardListController());
    final commentListController = Get.put(CommentListController());
    final nicknameController = Get.put(NicknameController());
    final tabController = Get.put(NewTabController());
    final _scrollController = ScrollController();
    _scrollController.addListener(() {
     if(_scrollController.offset == _scrollController.position.maxScrollExtent){
       if(tabController.controller.index==0){
         activityPostLoadFetch();
       }
       if(tabController.controller.index==1){
         activityCommentLoadFetch();
       }
     }
    });

    Future<bool> _onWillPop() async {
      Get.offAll(()=>const MainPage());
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: keyController.scaffoldKey,
        backgroundColor: MainColor.six,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: MainColor.six,
              title: const Text("내 활동", style: MainPageTheme.title),
              pinned: true,
              leadingWidth: MediaQuery.of(context).size.width * 0.2106,
              leading: Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
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
                        Get.offAll(()=>const MainPage());
                      },
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child:  Container(
                height: MediaQuery.of(context).size.width/2,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text(nicknameController.nickname.value,style: CommunityPageTheme.activityNickname,),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.12,
                          backgroundImage:profile!.image,
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
                              checkTimerController.time.value ?
                              checkTimerController.stop(context) : await getProfile("MainPage");
                            }, child: const Text("프로필 설정",style: CommunityPageTheme.activityButton,))),
                        Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color:MainColor.one,
                            ),
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextButton(onPressed: (){}, child: const Text("구매내역",style: CommunityPageTheme.activityButton))),
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
              child: Padding(
                padding: EdgeInsets.only(bottom: GetPlatform.isIOS ? 30 : 0),
                child: TabBarView(
                  controller: tabController.controller,
                    children:[
                      CustomScrollView(
                        controller: _scrollController,
                          slivers: [
                            Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                              return  boardListController.boardList[index];
                            },childCount: boardListController.boardList.length))),
                          ],
                      ),
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                            return  commentListController.commentList[index];
                          },childCount: commentListController.commentList.length))),
                        ],
                      ),
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                            return  boardListController.boardList[index];
                          },childCount: boardListController.boardList.length))),
                        ],
                      )
                ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;
  final index = 0.obs;
  final keyController = Get.put(KeyController());
  //final prevention = false.obs;

  @override
  void onInit() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
     if(controller.index==0 && index.value != controller.index){
       checkTimerController.time.value ?
       checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
        activityPostStartFetch();
     }
     if(controller.index==1 && index.value != controller.index){
       checkTimerController.time.value ?
       checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
       activityCommentStartFetch();
     }
     if(controller.index==2 && index.value != controller.index){
       checkTimerController.time.value ?
       checkTimerController.stop(keyController.scaffoldKey.currentContext!) :
       activityLikedStartFetch();
     }
     index.value = controller.index;
    });
    super.onInit();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}


class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final tabController = Get.put(NewTabController());

    return Container(
      color: MainColor.six,
      child:  TabBar(
        controller: tabController.controller,
        tabs: const [
          Tab(
            child: Text(
              "작성글",style: CommunityPageTheme.tabBarText,
            ),
          ),
          Tab(
            child: Text(
              "작성댓글",style: CommunityPageTheme.tabBarText,
            ),
          ),
          Tab(
            child: Text(
              "좋아요한 글",style: CommunityPageTheme.tabBarText,
            ),
          ),
        ],
        unselectedLabelColor: MainColor.one,
        labelColor: Colors.white,
        indicatorColor: MainColor.three,
        indicatorWeight: 2.5,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}