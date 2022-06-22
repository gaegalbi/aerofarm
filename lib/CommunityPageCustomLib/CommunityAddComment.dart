import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CommunityPage/CommunityPageReply.dart';
import '../themeData.dart';

class AddComment extends StatelessWidget {
  final Map<String, dynamic> keywords;
  final String id;
  final int index;
  final String writer;
  final String title;
  final String views;
  final String likes;
  final String comments;
  final String realDate;
  final String category;
  const AddComment({Key? key, required this.keywords,  required this.id,required this.index, required this.writer, required this.title, required this.views, required this.likes, required this.comments, required this.realDate, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Get.to(() => CommunityPageReply(id:id, index: index,likes: likes, comments: comments, title: title, views: views, writer: writer, realDate: realDate, category: category, communityCategory: keywords['communityCategory'],));
      },
      child: Container(
        //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02,
            bottom: MediaQuery.of(context).size.height*0.02),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Colors.white))
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                radius:
                MediaQuery.of(context).size.width *
                    0.09,
                backgroundImage: const AssetImage(
                    "assets/images/profile.png"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(keywords['writer'],style: CommunityPageTheme.commentWriter,),
                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width*0.63,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: RichText(
                          maxLines: null,
                          text: TextSpan(text:  keywords['content'],
                              style:CommunityPageTheme.postFont),
                        )),
                    ],
                  )),
                Row(
                  children: [
                    Text(keywords['date'],style: CommunityPageTheme.commentDate,),
                    Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.053),
                        height: MediaQuery.of(context).size.height*0.025,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.zero)),
                          onPressed: () {},
                          child: const Text(
                            "답글 쓰기",
                            style: CommunityPageTheme.commentDate,
                          ),
                        ))
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
