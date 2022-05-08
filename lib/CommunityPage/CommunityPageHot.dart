import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPageHot extends StatefulWidget {
  const CommunityPageHot({Key? key}) : super(key: key);

  @override
  State<CommunityPageHot> createState() => _CommunityPageHotState();
}

class _CommunityPageHotState extends State<CommunityPageHot> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //foregroundColor: Colors.transparent,
        backgroundColor: MainColor.six,
        //backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.2106,
        leading: Container(
          margin:
          EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: FittedBox(
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  // 패딩 설정
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )),
        ),
        title: const Text(
          "도시농부",
          style: MainTheme.title,
        ),
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
                  Get.off(() => const MainPage());
                },
              ),
            ),
          )
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        child: const Drawer(
          backgroundColor: Colors.black,
          child: CommunityPageDrawer(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        color: MainColor.six,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.016),
                child: const Text(
                  "인기게시판",
                  style: Community.title,
                  textAlign: TextAlign.left,
                )),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.012),
              decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "필독",
                      style: Community.main,
                    ),
                  ),
                  const Text(
                    "도시농부 서비스 안내",
                    style: Community.main,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.014,
              ),
              height: MediaQuery.of(context).size.height * 0.69,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02),
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
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                                right:
                                MediaQuery.of(context).size.width * 0.04),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                        MediaQuery.of(context).size.height *
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
    );
  }
}
