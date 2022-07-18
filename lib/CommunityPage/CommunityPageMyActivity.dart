import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:capstone/LoginPage/LoginPageLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MainPage/MainPageDrawer.dart';
import '../themeData.dart';

class CommunityPageMyActivity extends StatelessWidget {
  const CommunityPageMyActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardListController = Get.put(BoardListController());
    final nicknameController = Get.put(NicknameController());
    final _scrollController = ScrollController();
    _scrollController.addListener(() {
     if(_scrollController.offset == _scrollController.position.maxScrollExtent){
       writePostLoadFetch();
     }
    });

    writePostStartFetch();
    return Scaffold(
      backgroundColor: MainColor.six,
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
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
                        Get.back();
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
                child: TabBarView(children:[
                  CustomScrollView(
                    controller: _scrollController,
                      slivers: [
                        Obx(()=>SliverList(delegate: SliverChildBuilderDelegate((context,index){
                          return  boardListController.boardList[index];
                        },childCount: boardListController.boardList.length))),
                      ],
                  ),
                  Container(color: Colors.red,),
                  Container(color: Colors.blue,),
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


class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MainColor.six,
      child: const TabBar(
        tabs: [
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