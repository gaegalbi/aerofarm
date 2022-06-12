import 'package:flutter/material.dart';
import '../themeData.dart';

class AddComment extends StatelessWidget {
  final Map<String, dynamic> keywords;

  const AddComment({Key? key, required this.keywords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        //Get.to(()=> ());
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
                  child: Text(
                    keywords['content'],
                    style: CommunityPageTheme.postFont,
                  ),
                ),
                Text(keywords['date'],style: CommunityPageTheme.commentDate,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
