import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../utils/CheckTimer.dart';

class Comment{
  String id="";
  String writer="";
  String date="";
  String content="";
  String postId="";
  String writerId="";
  bool deleteTnF = false;
  int groupId=0;
  String parentId = "";
  String parentNickname="";
  Image? picture = const Image(
    image: AssetImage("assets/images/profile.png"),
  );
  String title="";

  Comment();

  Comment.fetch(Map<String, dynamic> data){
    id = data['id'].toString();
    writer = data['writer'];
    date = dateInfoFormat.format(DateTime.parse(data['localDateTime']));
    content = data['content'];
    postId = data['postId'].toString();
    writerId = data['writerId'].toString();
    deleteTnF = data['deleteTnF'];
    groupId = data['groupId'];
    parentId = data['parentId'].toString();
    if(data['parentNickname']!=null){
      parentNickname = data['parentNickname'];
    }else{
      parentNickname = "null";
    }
    picture = Image.network("http://$serverIP${data['picture']}");
  }

  Comment.mine(Map<String, dynamic> data){
    postId = data['postId'].toString();
    content = data['content'];
    date = dateFormat.format(DateTime.parse(data['createdDate']));
    deleteTnF = data['deleteTnF'];
    title = data['title'];
  }
}