import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CurrentTime.dart';
import 'CommunityPageFloating.dart';

class CommunityPageAll extends StatefulWidget {
  const CommunityPageAll({Key? key}) : super(key: key);

  @override
  State<CommunityPageAll> createState() => _CommunityPageAllState();
}

class _CommunityPageAllState extends State<CommunityPageAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CommunityPageFloating(),
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
                child: const Text(
                  "전체게시판",
                  style: Community.title,
                )),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.012),
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2, color: Colors.white),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.64,
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.06),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          const CurrentTime(
                                            type: true, style: 'sub',
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
                                      borderRadius: BorderRadius.circular(10)),
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
    );
  }
}
