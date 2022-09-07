import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../model/Board.dart';
import '../model/Screen.dart';
import '../screen/CommunityReplyScreen.dart';
import '../screen/CommunityScreen.dart';
import 'package:http/http.dart' as http;
import '../themeData.dart';

class CustomBottomAppBar extends StatefulWidget {
  final Board board;
  final RouteController routeController;
  final UserController userController;
  const CustomBottomAppBar({Key? key, required this.board, required this.routeController,required this.userController}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.indigo,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReadPostBottomAppBarButton(
            icon: const Icon(
              Icons.menu,
              size: 35,
            ),
            text: const Text(
              "목록으로",
              style: CommunityScreenTheme.bottomAppBarList,
            ),
            onPressed: () {
              Get.offAll(() => CommunityScreen(
                boardType: widget.board.category,
              ));
            },
          ),
          Row(
            children: [
              ReadPostBottomAppBarButton(
                icon: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Icon(
                      widget.board.like == true
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 35,
                      color: Colors.red,
                    )),
                text: Text(
                  widget.board.likeCount.toString(),
                  style: CommunityScreenTheme.bottomAppBarFavorite,
                ),
                onPressed: () async {
                  //누를때 한번 더 확인
                  if(checkTimerController.time.value){
                    checkTimerController.stop(context);
                  }else{
                    if(!widget.board.deleteTnF){
                      Map<String, String> _queryParameters =  <String, String>{
                        'postId': widget.board.id,
                      };
                      final likeResponse = await http
                          .get(Uri.http(serverIP, '/api/islike',_queryParameters),
                          headers:{
                            "Content-Type": "application/x-www-form-urlencoded",
                            "Cookie":"remember-me=${widget.userController.user.value.rememberMe};JSESSIONID=${widget.userController.user.value.session}",
                          }
                      );
                      if(likeResponse.statusCode ==200) {
                        widget.board.fetchLike(likeResponse.body);
                        //readPostController.setIsLike(likeResponse.body);
                      }else{
                        throw Exception("checkLike error");
                      }
                      var data = {
                        "postId":widget.board.id,
                      };
                      var body = json.encode(data);

                      String work = "";

                      if(widget.board.like){
                        work = "/deleteLike";
                      }else{
                        work = "/createLike";
                      }

                      setState((){
                        widget.board.setLike(widget.board.like);
                      });

                      await http.post(
                        Uri.http(serverIP, work),
                        headers: {
                          "Content-Type": "application/json",
                          "Cookie":"remember-me=${widget.userController.user.value.rememberMe};JSESSIONID=${widget.userController.user.value.session}",
                        },
                        encoding: Encoding.getByName('utf-8'),
                        body: body,
                      );
                    }
                  }
                },
              ),
              ReadPostBottomAppBarButton(
                icon: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(
                    Icons.chat,
                    size: 35,
                  ),
                ),
                text: Obx(()=>Text(
                  widget.routeController.commentCount.value.toString(),
                  style: CommunityScreenTheme.bottomAppBarReply,
                ),),
                onPressed: () {
                  widget.routeController.setCurrent(Screen.reply);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          CommunityReplyScreen(board: widget.board)));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}



@immutable
class ReadPostBottomAppBarButton extends StatelessWidget {
  const ReadPostBottomAppBarButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}