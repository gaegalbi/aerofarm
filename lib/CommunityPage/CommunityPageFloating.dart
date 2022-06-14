import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CommunityPageCreatePost.dart';


class CommunityPageFloating extends StatelessWidget {
  final String id;
  const CommunityPageFloating({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Colors.indigo,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Get.to(()=>CommunityPageCreatePost(id:id));
            },
            icon: Image.asset("assets/images/create.png")),
    );
  }
}