import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CommunityPageCreatePost.dart';

class CommunityPageFloating extends StatelessWidget {
  final String id;
  final String type;
  final String title;

  const CommunityPageFloating(
      {Key? key, required this.id, required this.type, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.indigo,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.to(() => CommunityPageCreatePost(
                  id: id,
                  type: type,
                  title: title,
                ));
          },
          icon: Image.asset("assets/images/create.png")),
    );
  }
}
