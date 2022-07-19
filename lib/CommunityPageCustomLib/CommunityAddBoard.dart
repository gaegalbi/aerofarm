import 'package:capstone/CommunityPageCustomLib/CommunityFetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CommunityPage/CommunityPageReadPost.dart';
import '../CurrentTime.dart';
import '../themeData.dart';

final Map<String,String >changeFilter ={
  "NORMAL":"일반",
  "HOBBY":"취미",
  "GAME":"게임",
  "TRAVEL":"여행",
  "DAILY":"일상",
};

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
    final loadingController = Get.put(LoadingController());
    String current = dateFormat.format(DateTime.now());
    String date = dateFormat.format(DateTime.parse(keywords['modifiedDate']));
    if(current == date.substring(0, 10)) {
      date = keywords['modifiedDate'].substring(11,16);
    }else{
      date = date.substring(2,10);
    }
    if(keywords['deleteTnF']){
      keywords['title'] = "삭제 처리된 게시글입니다.";
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      padding: EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.white),
          )),
      child: InkWell(
        onTap: () {
          loadingController.setTrue();
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
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.008),
                    child: Row(
                      children: [
                        Text("[${changeFilter[keywords['filter']]!}] ",style: CommunityPageTheme.filter,),
                        Text(
                          keywords['title'],
                          style: CommunityPageTheme.main,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          keywords['writer'],
                          overflow: TextOverflow.ellipsis,
                          style: CommunityPageTheme.subEtc,
                        ),
                      ),
                      Flexible(
                        flex: date.length ==5 ? 4 : 7,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            date,
                            style: CommunityPageTheme.subEtc,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "조회 ",
                              style: CommunityPageTheme.subEtc,
                            ),
                            Text(
                              keywords['views'].toString(),
                              style: CommunityPageTheme.subEtc,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Row(
                         // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "추천 ",
                              style: CommunityPageTheme.subEtc,
                            ),
                            Text(
                             keywords['likeCount'].toString(),
                              style: CommunityPageTheme.sub1,
                            ),
                          ],
                        ),
                      )
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
                      keywords['commentCount'].toString(),
                      style: CommunityPageTheme.subCommentCount,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "댓글",
                      style: CommunityPageTheme.subEtc,
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


/*
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
*/
