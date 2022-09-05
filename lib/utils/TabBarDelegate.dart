import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../provider/Controller.dart';
import '../themeData.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final tabController = Get.put(CustomTabController());

    return Container(
      color: MainColor.six,
      child:  TabBar(
        controller: tabController.controller,
        tabs: const [
          Tab(
            child: Text(
              "작성글",style: CommunityScreenTheme.tabBarText,
            ),
          ),
          Tab(
            child: Text(
              "작성댓글",style: CommunityScreenTheme.tabBarText,
            ),
          ),
          Tab(
            child: Text(
              "좋아요한 글",style: CommunityScreenTheme.tabBarText,
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