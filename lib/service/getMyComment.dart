import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/Comment.dart';
import '../provider/Controller.dart';

Future getMyCommentStart() async {
  final pageIndexController = Get.put(PageIndexController());
  final commentListController = Get.put(CommentListController());
  final userController = Get.put(UserController());

  pageIndexController.setUp();
  commentListController.commentClear();

  Map<String, String> _queryParameters = <String, String>{
    'page': pageIndexController.pageIndex.value.toString(),
  };
  Map<String, dynamic> data;
  final commentResponse = await http
      .get(Uri.http(serverIP, '/api/my/comments', _queryParameters),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //"Cookie": "JSESSIONID=$session",
        "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
      }
  );
  if (commentResponse.statusCode == 200) {
    data = jsonDecode(utf8.decode(commentResponse.bodyBytes));
    if(data['content'].length!=0) {
      for (int i = 0; i < data['content'].length; i++) {
        Comment comment = Comment.mine(data['content'][i]);
        commentListController.commentAdd(comment);
        commentListController.commentGroupIdList.add(comment.groupId);
        /* commentListController.commentAdd(AddComment(
          index: pageIndexController.pageIndex.value,
          keywords: data['content'][i],
          before: "MyActivity", selectReply: '',));*/
      }
    }
  }
  else {
    throw Exception("myComment Error");
  }
}