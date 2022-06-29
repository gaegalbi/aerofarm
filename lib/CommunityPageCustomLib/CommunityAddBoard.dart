import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CommunityPage/CommunityPageReadPost.dart';
import '../themeData.dart';

class AddBoard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> keywords;
  final String before;

  const AddBoard(
      {Key? key,
      required this.index,
      required this.keywords,
      required this.before})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1, color: Colors.white),
      )),
      child: InkWell(
        onTap: () {
          Get.to(() => CommunityPageReadPost(
                index: index,
                keywords: keywords,
                before: before,
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.008),
                      child: Text(
                        keywords['title'],
                        style: CommunityPageTheme.main,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          keywords['writer'],
                          overflow: TextOverflow.ellipsis,
                          style: CommunityPageTheme.sub,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          keywords['date'],
                          style: CommunityPageTheme.sub,
                        ),
                      ),
                      Flexible(
                          flex: 7,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Text(
                                      "조회 ",
                                      style: CommunityPageTheme.sub,
                                    ),
                                    Text(
                                      keywords['views'],
                                      style: CommunityPageTheme.sub,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Text(
                                      "추천 ",
                                      style: CommunityPageTheme.sub,
                                    ),
                                    Text(
                                      keywords['likes'],
                                      style: CommunityPageTheme.sub1,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.08,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      keywords['comments'],
                      style: CommunityPageTheme.sub,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "댓글",
                      style: CommunityPageTheme.sub,
                      textAlign: TextAlign.center,
                    ),
                  ]),
              decoration: BoxDecoration(
                  color: MainColor.one,
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}